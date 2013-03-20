import Network.Socket hiding (recv)
import Network.Socket.ByteString.Lazy (sendAll, recv)
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Builder as BB
import System.IO (Handle, IOMode(..), BufferMode(..), hSetBuffering, hClose)
import ESPacket
import HES.Messages.CreateStream
import qualified Commands as Cmd
import Data.UUID (UUID, toByteString)
import qualified Data.UUID.V4 as U4
import Data.Monoid (mappend)
import Text.ProtocolBuffers.WireMessage (messagePut, Wire)
import Text.ProtocolBuffers.Reflections (ReflectDescriptor)
import Text.ProtocolBuffers.Header (uFromString)
import Data.Word
import Data.Monoid
import Data.Binary.Get (runGetState)

main :: IO ()
main = withSocketsDo $
  do addrinfos <- getAddrInfo Nothing (Just "127.0.0.1") (Just "1113")
     let serveraddr = head addrinfos
     sock <- socket (addrFamily serveraddr) Stream defaultProtocol
     setSocketOption sock KeepAlive 1
     connect sock (addrAddress serveraddr)
     --h <- socketToHandle sock ReadWriteMode
     --hSetBuffering h NoBuffering

     (success, leftOver) <- createStreamCmd sock "firstStream"
     --hClose h
     sClose sock

createStreamCmd :: Socket -> String -> IO (Bool, L.ByteString)
createStreamCmd s streamName = do
  requestId <- uuidAsByteString
  correlationId <- uuidAsBuilder
  let 
    cmd     = CreateStream {
      event_stream_id = uFromString streamName,
      request_id = requestId,
      metadata = Just L.empty,
      allow_forwarding = True,
      is_json = True
    }
    packet = buildPacket cmd Cmd.createStream correlationId
  putStrLn "Sending packet..."
  sendAll s packet
  putStrLn "Receiving response..."
  --bytes <- recv s 1024
  --putStrLn "Received response:"
  --putStrLn $ display bytes
  (response, leftOver) <- readNext s L.empty
  putStrLn $ show response
  return (True, L.empty)

loopRead :: Handle -> IO ()
loopRead h = do
  bytes <- L.hGetNonBlocking h 1024
  if (L.length bytes > 0) 
    then (putStrLn (show bytes))
    else (loopRead h)

buildPacket :: (ReflectDescriptor msg, Wire msg) => msg -> Word8 -> BB.Builder -> L.ByteString
buildPacket content cmdType correlationId = BB.toLazyByteString builder
  where
    bytes       = messagePut content
    contentSize = fromIntegral (17 + L.length bytes) :: Word32
    builder     = (BB.word32LE contentSize) <> (BB.word8 Cmd.createStream) <> correlationId <> (BB.lazyByteString bytes)

uuidAsBuilder :: IO BB.Builder
uuidAsBuilder = fmap (BB.lazyByteString . toByteString) U4.nextRandom

uuidAsByteString :: IO L.ByteString
uuidAsByteString = BB.toLazyByteString `fmap` uuidAsBuilder

readNext :: Socket -> L.ByteString -> IO (ESPacket, L.ByteString)
readNext s leftOver = do      
  newBytes <- recv s 1024
  let allBytes = leftOver `L.append` newBytes
  case runGetState getESPacketM allBytes 0 of
    (Just pk, leftOver', _) -> return (pk, leftOver')
    (Nothing, leftOver', _) -> readNext s leftOver'

display :: L.ByteString -> String
display bs = case L.uncons bs of
  Just (head, tail) -> (show head) ++ " " ++ (display tail)
  Nothing           -> ""