{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ReadEventCompleted.ReadEventResult (ReadEventResult(..)) where
import Prelude ((+), (/), (.))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data ReadEventResult = Success
                     | NotFound
                     | NoStream
                     | StreamDeleted
                     deriving (Prelude'.Read, Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadEventResult
 
instance Prelude'.Bounded ReadEventResult where
  minBound = Success
  maxBound = StreamDeleted
 
instance P'.Default ReadEventResult where
  defaultValue = Success
 
toMaybe'Enum :: Prelude'.Int -> P'.Maybe ReadEventResult
toMaybe'Enum 0 = Prelude'.Just Success
toMaybe'Enum 1 = Prelude'.Just NotFound
toMaybe'Enum 2 = Prelude'.Just NoStream
toMaybe'Enum 3 = Prelude'.Just StreamDeleted
toMaybe'Enum _ = Prelude'.Nothing
 
instance Prelude'.Enum ReadEventResult where
  fromEnum Success = 0
  fromEnum NotFound = 1
  fromEnum NoStream = 2
  fromEnum StreamDeleted = 3
  toEnum
   = P'.fromMaybe (Prelude'.error "hprotoc generated code: toEnum failure for type HES.Messages.ReadEventCompleted.ReadEventResult")
      . toMaybe'Enum
  succ Success = NotFound
  succ NotFound = NoStream
  succ NoStream = StreamDeleted
  succ _ = Prelude'.error "hprotoc generated code: succ failure for type HES.Messages.ReadEventCompleted.ReadEventResult"
  pred NotFound = Success
  pred NoStream = NotFound
  pred StreamDeleted = NoStream
  pred _ = Prelude'.error "hprotoc generated code: pred failure for type HES.Messages.ReadEventCompleted.ReadEventResult"
 
instance P'.Wire ReadEventResult where
  wireSize ft' enum = P'.wireSize ft' (Prelude'.fromEnum enum)
  wirePut ft' enum = P'.wirePut ft' (Prelude'.fromEnum enum)
  wireGet 14 = P'.wireGetEnum toMaybe'Enum
  wireGet ft' = P'.wireGetErr ft'
  wireGetPacked 14 = P'.wireGetPackedEnum toMaybe'Enum
  wireGetPacked ft' = P'.wireGetErr ft'
 
instance P'.GPB ReadEventResult
 
instance P'.MessageAPI msg' (msg' -> ReadEventResult) ReadEventResult where
  getVal m' f' = f' m'
 
instance P'.ReflectEnum ReadEventResult where
  reflectEnum = [(0, "Success", Success), (1, "NotFound", NotFound), (2, "NoStream", NoStream), (3, "StreamDeleted", StreamDeleted)]
  reflectEnumInfo _
   = P'.EnumInfo
      (P'.makePNF (P'.pack ".HES.Messages.ReadEventCompleted.ReadEventResult") [] ["HES", "Messages", "ReadEventCompleted"]
        "ReadEventResult")
      ["HES", "Messages", "ReadEventCompleted", "ReadEventResult.hs"]
      [(0, "Success"), (1, "NotFound"), (2, "NoStream"), (3, "StreamDeleted")]