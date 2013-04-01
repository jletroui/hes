{-# LANGUAGE PackageImports #-}
module ESPacket (
  ESPacket(..), 
  getESPacket,
  putESMessage
  ) where

import qualified Data.ByteString.Lazy as L
import Data.Binary.Get (Get, getWord8, getWord32le, getLazyByteString, remaining, lookAhead)
import Data.Binary.Put (Put, putWord8, putWord32le, putLazyByteString)
import Data.Word
import Data.UUID (UUID, fromByteString, toByteString)
import Data.Maybe (fromJust)
import Text.ProtocolBuffers.WireMessage (messagePut, Wire)
import Text.ProtocolBuffers.Reflections (ReflectDescriptor)
import Control.Applicative

data ESPacket = ESPacket { 
  msgType       :: Word8, 
  correlationId :: UUID, 
  msg           :: L.ByteString }
  deriving (Show, Eq)

getESPacket :: Get ESPacket
getESPacket = do
  messageContentSize <- getMessageContentSize
  ESPacket <$> getWord8 <*> getUUID <*> getLazyByteString (fromIntegral messageContentSize)

getMessageContentSize :: Get Int
getMessageContentSize = ((subtract 17) . fromIntegral) `fmap` getWord32le

getUUID :: Get UUID
getUUID = (fromJust . fromByteString) `fmap` (getLazyByteString 16)

putESMessage :: (ReflectDescriptor msg, Wire msg) => Word8 -> UUID -> msg -> Put
putESMessage msgType msgCorrelationId msg = putESPacket packet
  where 
    msgContent = messagePut msg
    packet     = ESPacket msgType msgCorrelationId msgContent

putESPacket :: ESPacket -> Put
putESPacket (ESPacket msgType msgCorrelationId msgContent) = do
    putWord32le packetSize
    putWord8 msgType
    putLazyByteString (toByteString msgCorrelationId)
    putLazyByteString msgContent
  where 
    packetSize = fromIntegral (17 + L.length msgContent) :: Word32
