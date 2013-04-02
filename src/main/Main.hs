module Main(main) where

import qualified Data.ByteString.Lazy as L
import Data.ByteString.Char8 (pack)
import HES.ESPacket
import HES.Disp
import HES.Messages.CreateStream
import HES.Client
import qualified HES.Commands as Cmd
import Data.UUID (toByteString)
import qualified Data.UUID.V4 as U4
import Text.ProtocolBuffers.Header (uFromString)
import Data.Conduit (Source, Sink, yield, ($=), ($$))
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

displayESPacketSink :: Sink ESPacket IO ()
displayESPacketSink = CL.mapM_ $ \packet -> do
  putStrLn $ "Received msg " ++ (disp packet)