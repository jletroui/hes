import Network.Socket hiding (recv)
import Network.Socket.ByteString (recv, sendAll)
import qualified Data.ByteString.Lazy as L
import System.IO (Handle, IOMode(..), BufferMode(..), hSetBuffering, hClose)
import ESPacket


main = withSocketsDo $
  do addrinfos <- getAddrInfo Nothing (Just "127.0.0.1") (Just "1113")
     let serveraddr = head addrinfos
     sock <- socket (addrFamily serveraddr) Stream defaultProtocol
     setSocketOption sock KeepAlive 1
     connect sock (addrAddress serveraddr)
     h <- socketToHandle sock ReadWriteMode
     hSetBuffering h NoBuffering

     (response, leftOver) <- readNext h L.empty
     putStrLn $ show response
     hClose h
     sClose sock

readNext :: Handle -> L.ByteString -> IO (ESPacket, L.ByteString)
readNext h leftOver = do
  newBytes <- L.hGet h 1024
  case next newBytes leftOver of
    Right (pk, leftOver') -> 
      return (pk, leftOver')
    Left bytes            -> 
      -- TODO: wait a few ms
      readNext h bytes

next :: L.ByteString -> L.ByteString -> Either L.ByteString (ESPacket, L.ByteString)
next newBytes leftOver = next' packet
  where 
    allBytes        = leftOver `L.append` newBytes
    packet          = maybeESPacket (allBytes)
    next' (Just pk) = Right (pk, L.drop (fromIntegral (ESPacket.totalSize pk)) allBytes)
    next' _         = Left allBytes
