module HES.Client(
  newClient,
  createStream) where

import HES.ESPacket
import HES.Disp
import qualified HES.Commands as Msg
import HES.Messages.CreateStream
import HES.Messages.CreateStreamCompleted

import Data.Word
import qualified Data.Map as M
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString as B
import Data.ByteString.Char8 (pack)
import Data.Binary.Get (runGetIncremental, Decoder(..))
import Data.Binary.Put (runPut)
import qualified Data.UUID.V4 as U4
import Data.UUID (UUID, toByteString)
import Control.Monad.IO.Class (liftIO)
import Data.Conduit (Source, Conduit, Sink, await, leftover, yield, ($=), ($$), (=$=))
import Data.Conduit.Network
import qualified Data.Conduit.List as CL
import Control.Concurrent.Chan.Strict
import Control.Concurrent.MVar.Strict
import Control.Concurrent.Async
import Control.Concurrent (forkIO)
import Control.DeepSeq (NFData, rnf)
import Text.ProtocolBuffers.WireMessage (Wire, messageGet, messagePut)
import Text.ProtocolBuffers.Reflections (ReflectDescriptor)
import Text.ProtocolBuffers.Header (uFromString)

data HESClient = HC (Chan HESAction) (Chan ESPacket) -- a coordination channel (reader is the coordinator) and an outbound channel (reader is the source writing to the socket)

data HESAction = Sending ESPacket (MVar ESPacket) | -- the command to send to server and an MVar waiting for the response
                 Receiving ESPacket -- what the server sent us

instance NFData HESAction where
  rnf (Sending pk mvar) = rnf pk `seq`
                          rnf mvar `seq`
                          ()                  
  rnf (Receiving pk)    = rnf pk `seq` 
                          ()                  

-- | This command is quite boilerplatty, so hide it, but still expose the response that is easy to read and pattern match
createStream :: String -> HESClient -> IO (Async CreateStreamCompleted)
createStream streamName client = do
  requestId <- U4.nextRandom
  let cmd = CreateStream {
        event_stream_id = uFromString streamName,
        request_id = (toByteString requestId),
        metadata = Just L.empty,
        allow_forwarding = True,
        is_json = True
      }
  callServer Msg.createStream cmd client

-- | Boilerplate necessary for each command: handles serialization / deserialization + create the future for each command
callServer :: (Wire cmd, Wire resp, ReflectDescriptor cmd, ReflectDescriptor resp) => Word8 -> cmd -> HESClient -> IO (Async resp)
callServer cmdType cmd (HC coord _) = do
  cid <- U4.nextRandom
  let pk = ESPacket cmdType cid (messagePut cmd)
  async $ do
    mvar <- newEmptyMVar
    writeChan coord (Sending pk mvar)
    ESPacket _ _ respBody <- takeMVar mvar 
    let Right (resp, _) = messageGet respBody   
    return $ resp

-- | The coordinator is responsible for matching the responses with the commands. It also handles the special heart beat
-- requests from the server.
coordinateCalls :: HESClient -> IO ()
coordinateCalls (HC coord toServer) = coordinateCalls' M.empty
  where 
    coordinateCalls' :: M.Map UUID (MVar ESPacket) -> IO ()
    coordinateCalls' pendingCalls = do
      act <- readChan coord
      case act of
        Sending pk@(ESPacket _ cid _) mvar -> do
          writeChan toServer pk
          coordinateCalls' $ M.insert cid mvar pendingCalls
        Receiving (ESPacket hb cid _) | hb == Msg.heartbeatRequestCommand -> do
          writeChan toServer (ESPacket Msg.heartbeatResponseCommand cid L.empty)
          coordinateCalls' pendingCalls
        Receiving pk@(ESPacket _ cid _) -> do
          case M.lookup cid pendingCalls of
            Just mvar -> do
              putMVar mvar pk
            _ -> do
              return ()
          coordinateCalls' $ M.delete cid pendingCalls

-- | Creates a new EventStore client
newClient :: Int -> String -> IO HESClient
newClient port host = do
  chan1 <- newChan
  chan2 <- newChan
  let settings = clientSettings port (pack host)
      client   = HC chan1 chan2
  _ <- forkIO $ coordinateCalls client
  _ <- forkIO $ runTCPClient settings $ \server -> do
    _ <- forkIO $ (appSource server) $= toESPacketConduit $$ (toClientSink client)
    (fromClientSource client) $= fromESPacketConduit $$ (appSink server)
  return client

toESPacketConduit :: Conduit B.ByteString IO ESPacket
toESPacketConduit = push $ runGetIncremental getESPacket 
  where
    push (Fail _ _ err) =
      error err
    push (Partial cont) = do
      nextChunk <- await
      maybe (return ()) (\_ -> push $ cont nextChunk) nextChunk
    push (Done leftOver _ packet) = do
      yield packet
      leftover leftOver
      toESPacketConduit

fromESPacketConduit :: Conduit ESPacket IO B.ByteString      
fromESPacketConduit = do
  packet <- await
  case packet of
    Nothing -> 
      return ()
    Just pk -> do
      yield $ serialize pk
      fromESPacketConduit
  where serialize = L.toStrict . runPut . putESPacket

toClientSink :: HESClient -> Sink ESPacket IO ()
toClientSink (HC coord _) = CL.mapM_ $ \packet -> do
  writeChan coord (Receiving packet)

fromClientSource :: HESClient -> Source IO ESPacket
fromClientSource (HC _ toServer) = fromClientSource'
  where
    fromClientSource' :: Source IO ESPacket 
    fromClientSource' = do
      packet <- liftIO $ readChan toServer
      yield packet
      fromClientSource'