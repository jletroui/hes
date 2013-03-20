{-# LANGUAGE PackageImports #-}
module ESPacket (
  ESPacket(..), 
  getESPacketM
  ) where

import qualified Data.ByteString.Lazy as L
import Data.Binary.Get (Get, getWord32le, getLazyByteString, getWord8, remaining, lookAhead)
import Data.Word
import "uuid" Data.UUID (UUID, fromByteString)
import Data.Maybe (fromJust)

data ESPacket = ESPacket { 
  msgType       :: Word8, 
  correlationId :: UUID, 
  msg           :: L.ByteString }
  deriving (Show, Eq)

getESPacketM :: Get (Maybe ESPacket)
getESPacketM = do
  remainingLength <- remaining
  if remainingLength <= 4
    then
      return Nothing
    else do
      sz <- lookAhead getWord32le
      if remainingLength < 4 + (fromIntegral sz)
        then
          return Nothing
        else
          getESPacket >>= return . Just

getESPacket :: Get ESPacket
getESPacket = do
  sz  <- getMessageSize
  tp  <- getWord8
  cid <- getUUID
  mg  <- getLazyByteString (fromIntegral sz)
  return $ ESPacket { 
    msgType = tp, 
    correlationId = cid, 
    msg = mg }

getMessageSize :: Get Int
getMessageSize = ((\i -> i - 17) . fromIntegral) `fmap` getWord32le

getUUID :: Get UUID
getUUID = fmap (fromJust . fromByteString) (getLazyByteString 16)

