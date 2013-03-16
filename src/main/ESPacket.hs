module ESPacket (
  ESPacket(..), 
  maybeESPacket
  ) where

import qualified Data.ByteString.Lazy as L
import Data.Binary.Get (Get, runGet, getWord32le, uncheckedLookAhead)
import Data.Word

data ESPacket = ESPacket { totalSize :: Int, payload :: L.ByteString }
  deriving (Show, Eq)

maybeWord32 :: L.ByteString -> Maybe Word32
maybeWord32 bs
  | L.length bs > 4 = Just (runGet getWord32le bs)
  | otherwise       = Nothing    

maybeBytes :: L.ByteString -> Word32 -> Maybe L.ByteString
maybeBytes bs n
  | L.length bs >= (fromIntegral n) = Just $ runGet (uncheckedLookAhead (fromIntegral n)) bs
  | otherwise                       = Nothing    

maybeESPacket :: L.ByteString -> Maybe ESPacket
maybeESPacket bs = do
  sz          <- maybeWord32 bs
  packetBytes <- maybeBytes bs sz
  return ESPacket { totalSize = (fromIntegral sz), payload = L.drop 4 packetBytes }  