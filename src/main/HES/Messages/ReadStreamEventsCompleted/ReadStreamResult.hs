{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ReadStreamEventsCompleted.ReadStreamResult (ReadStreamResult(..)) where
import Prelude ((+), (/), (.))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data ReadStreamResult = Success
                      | NoStream
                      | StreamDeleted
                      | NotModified
                      | Error
                      deriving (Prelude'.Read, Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadStreamResult
 
instance Prelude'.Bounded ReadStreamResult where
  minBound = Success
  maxBound = Error
 
instance P'.Default ReadStreamResult where
  defaultValue = Success
 
toMaybe'Enum :: Prelude'.Int -> P'.Maybe ReadStreamResult
toMaybe'Enum 0 = Prelude'.Just Success
toMaybe'Enum 1 = Prelude'.Just NoStream
toMaybe'Enum 2 = Prelude'.Just StreamDeleted
toMaybe'Enum 3 = Prelude'.Just NotModified
toMaybe'Enum 4 = Prelude'.Just Error
toMaybe'Enum _ = Prelude'.Nothing
 
instance Prelude'.Enum ReadStreamResult where
  fromEnum Success = 0
  fromEnum NoStream = 1
  fromEnum StreamDeleted = 2
  fromEnum NotModified = 3
  fromEnum Error = 4
  toEnum
   = P'.fromMaybe
      (Prelude'.error "hprotoc generated code: toEnum failure for type HES.Messages.ReadStreamEventsCompleted.ReadStreamResult")
      . toMaybe'Enum
  succ Success = NoStream
  succ NoStream = StreamDeleted
  succ StreamDeleted = NotModified
  succ NotModified = Error
  succ _ = Prelude'.error "hprotoc generated code: succ failure for type HES.Messages.ReadStreamEventsCompleted.ReadStreamResult"
  pred NoStream = Success
  pred StreamDeleted = NoStream
  pred NotModified = StreamDeleted
  pred Error = NotModified
  pred _ = Prelude'.error "hprotoc generated code: pred failure for type HES.Messages.ReadStreamEventsCompleted.ReadStreamResult"
 
instance P'.Wire ReadStreamResult where
  wireSize ft' enum = P'.wireSize ft' (Prelude'.fromEnum enum)
  wirePut ft' enum = P'.wirePut ft' (Prelude'.fromEnum enum)
  wireGet 14 = P'.wireGetEnum toMaybe'Enum
  wireGet ft' = P'.wireGetErr ft'
  wireGetPacked 14 = P'.wireGetPackedEnum toMaybe'Enum
  wireGetPacked ft' = P'.wireGetErr ft'
 
instance P'.GPB ReadStreamResult
 
instance P'.MessageAPI msg' (msg' -> ReadStreamResult) ReadStreamResult where
  getVal m' f' = f' m'
 
instance P'.ReflectEnum ReadStreamResult where
  reflectEnum
   = [(0, "Success", Success), (1, "NoStream", NoStream), (2, "StreamDeleted", StreamDeleted), (3, "NotModified", NotModified),
      (4, "Error", Error)]
  reflectEnumInfo _
   = P'.EnumInfo
      (P'.makePNF (P'.pack ".HES.Messages.ReadStreamEventsCompleted.ReadStreamResult") []
        ["HES", "Messages", "ReadStreamEventsCompleted"]
        "ReadStreamResult")
      ["HES", "Messages", "ReadStreamEventsCompleted", "ReadStreamResult.hs"]
      [(0, "Success"), (1, "NoStream"), (2, "StreamDeleted"), (3, "NotModified"), (4, "Error")]