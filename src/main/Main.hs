module Main(main, main2) where

import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString as B
import Data.ByteString.Char8 (pack)
import ESPacket
import Disp
import HES.Messages.CreateStream
import qualified Commands as Cmd
import Data.UUID (toByteString)
import qualified Data.UUID.V4 as U4
import Text.ProtocolBuffers.Header (uFromString)
import Data.Binary.Get (runGetIncremental, Decoder(..))
import Data.Binary.Put (runPut)
import Data.Conduit (Source, Conduit, Sink, await, leftover, yield, ($=), ($$), (=$=))
import qualified Data.Conduit.List as CL
import Data.Conduit.Network
import Text.ProtocolBuffers.WireMessage (messagePut)
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = do
  let settings = clientSettings 1113 (pack "localhost")
  runTCPClient settings $ \app -> do
    oneCmdSource $= fromESPacketConduit $$ (appSink app)
    (appSource app) $= toESPacketConduit $$ displayESPacketSink

oneCmdSource :: Source IO ESPacket  
oneCmdSource = do
  requestId <- liftIO U4.nextRandom
  cmdCorrelationId <- liftIO U4.nextRandom
  let cmd = CreateStream {
        event_stream_id = uFromString "stream-test-1",
        request_id = (toByteString requestId),
        metadata = Just L.empty,
        allow_forwarding = True,
        is_json = True
      }
      packet = ESPacket Cmd.createStream cmdCorrelationId (messagePut cmd)
  yield packet

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

displayESPacketSink :: Sink ESPacket IO ()
displayESPacketSink = CL.mapM_ $ \packet -> do
  putStrLn $ "Received msg " ++ (disp packet)