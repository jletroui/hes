import Network.Socket hiding (recv)
import Network.Socket.ByteString.Lazy (sendAll, recv)
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString as B
import ESPacket
import HES.Messages.CreateStream
import qualified Commands as Cmd
import Data.UUID (toByteString)
import qualified Data.UUID.V4 as U4
import Text.ProtocolBuffers.Header (uFromString)
import Data.Binary.Get (runGetState, runGetIncremental, Decoder(..))
import Data.Binary.Put (runPut)
import Control.Monad (liftM)
import Data.Conduit (Conduit, await, leftover, yield)

main :: IO ()
main = withSocketsDo $
  do addrinfos <- getAddrInfo Nothing (Just "127.0.0.1") (Just "1113")
     let serveraddr = head addrinfos
     sock <- socket (addrFamily serveraddr) Stream defaultProtocol
     setSocketOption sock KeepAlive 1
     connect sock (addrAddress serveraddr)
     --h <- socketToHandle sock ReadWriteMode
     --hSetBuffering h NoBuffering

     (_, _) <- createStreamCmd sock "firstStream"
     --hClose h
     sClose sock

createStreamCmd :: Socket -> String -> IO (Bool, L.ByteString)
createStreamCmd s streamName = do
  requestId <- nextUUIDAsLazyByteString
  cmdCorrelationId <- U4.nextRandom
  let 
    cmd     = CreateStream {
      event_stream_id = uFromString streamName,
      request_id = requestId,
      metadata = Just L.empty,
      allow_forwarding = True,
      is_json = True
    }
    packet = runPut $ putESMessage Cmd.createStream cmdCorrelationId cmd
  putStrLn "Sending packet..."
  sendAll s packet
  putStrLn "Receiving response..."
  (response, _) <- readNext s L.empty
  putStrLn $ show response
  return (True, L.empty)

toESPacketConduit :: Conduit B.ByteString IO ESPacket
toESPacketConduit = push $ runGetIncremental getESPacket 
  where
    push (Fail _ _ err) = 
      error err
    push (Partial cont) = do
      nextChunk <- await
      push $ cont nextChunk
    push (Done leftOver _ packet) = do
      yield packet
      leftover leftOver
      toESPacketConduit

nextUUIDAsLazyByteString :: IO L.ByteString
nextUUIDAsLazyByteString = liftM toByteString U4.nextRandom

readNext :: Socket -> L.ByteString -> IO (ESPacket, L.ByteString)
readNext s leftOver = do      
  newBytes <- recv s 1024
  let allBytes = leftOver `L.append` newBytes
      (pk, leftOver', _) = runGetState getESPacket allBytes 0
  return (pk, leftOver')

display :: L.ByteString -> String
display bs = case L.uncons bs of
  Just (x, xs) -> (show x) ++ " " ++ (display xs)
  Nothing           -> ""