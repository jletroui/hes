module HES.Disp where

import Data.Word
import Data.UUID (UUID)
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString as B

-- | Human readable display of a, for debugging purpose
class Disp a where
  disp :: a -> String

instance Disp Word8 where
  disp = show

instance Disp UUID where
  disp = show

instance Disp a => Disp (Maybe a) where
  disp a = case a of
    Just x -> "Just " ++ (disp x)
    _ -> "Nothing"

instance Disp L.ByteString where
  disp bs = "[" ++ (show $ L.length bs) ++ "] " ++ (disp' bs)
    where
      disp' bs' = case L.uncons bs' of
        Just (x, xs) -> (disp x) ++ " " ++ (disp' xs)
        Nothing      -> ""

instance Disp B.ByteString where
  disp bs = "[" ++ (show $ B.length bs) ++ "] " ++ (disp' bs)
    where
      disp' bs' = case B.uncons bs' of
        Just (x, xs) -> (disp x) ++ " " ++ (disp' xs)
        Nothing      -> ""
