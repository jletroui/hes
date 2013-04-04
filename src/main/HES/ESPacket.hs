{-# LANGUAGE PackageImports #-}
module HES.ESPacket (
  ESPacket(..), 
  getESPacket,
  putESMessage,
  putESPacket
  ) where

import qualified Data.ByteString.Lazy as L
import Data.Binary.Get (Get, getWord8, getWord32le, getLazyByteString)
import Data.Binary.Put (Put, putWord8, putWord32le, putLazyByteString)
import Data.Word
import Data.UUID (UUID, fromByteString, toByteString)
import Data.Maybe (fromJust)
import Text.ProtocolBuffers.WireMessage (messagePut, Wire)
import Text.ProtocolBuffers.Reflections (ReflectDescriptor)
import Control.Applicative
import HES.Disp
import System.IO (nativeNewline, Newline(..))
import Control.DeepSeq (NFData, rnf)

data ESPacket = ESPacket { 
  msgType          :: Word8, 
  msgCorrelationId :: UUID, 
  msgBody          :: L.ByteString }
  deriving (Show, Eq)

getESPacket :: Get ESPacket
getESPacket = do
  messageBodySize <- getMessageBodySize
  ESPacket <$> getWord8 <*> getUUID <*> getLazyByteString (fromIntegral messageBodySize)

getMessageBodySize :: Get Int
getMessageBodySize = ((subtract 17) . fromIntegral) `fmap` getWord32le

getUUID :: Get UUID
getUUID = (fromJust . fromByteString) `fmap` (getLazyByteString 16)

putESMessage :: (ReflectDescriptor msg, Wire msg) => Word8 -> UUID -> msg -> Put
putESMessage typ correlationId msg = putESPacket packet
  where 
    body   = messagePut msg
    packet = ESPacket typ correlationId body

putESPacket :: ESPacket -> Put
putESPacket (ESPacket typ correlationId body) = do
    putWord32le packetSize
    putWord8 typ
    putLazyByteString (toByteString correlationId)
    putLazyByteString body
  where 
    packetSize = fromIntegral (17 + L.length body) :: Word32

instance NFData ESPacket where
  rnf (ESPacket t cid body) = rnf t `seq`
                              cid `seq` -- Already strict
                              rnf body `seq`
                              ()

instance Disp ESPacket where
  disp pk = "type: " ++ (disp $ msgType pk) ++ " cid: " ++ 
    (disp $ msgCorrelationId pk) ++ newLineStr ++
    (disp $ msgBody pk) 

newLineStr :: String
newLineStr = case nativeNewline of
  LF -> "\n"
  CRLF -> "\r\n"