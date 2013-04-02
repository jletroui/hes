module HES.Client where

import HES.ESPacket
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString as B
import Data.Binary.Get (runGetIncremental, Decoder(..))
import Data.Binary.Put (runPut)
import Data.Conduit (Source, Conduit, Sink, await, leftover, yield, ($=), ($$), (=$=))

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