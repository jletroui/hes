{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.OperationResult (OperationResult(..)) where
import Prelude ((+), (/), (.))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data OperationResult = Success
                     | PrepareTimeout
                     | CommitTimeout
                     | ForwardTimeout
                     | WrongExpectedVersion
                     | StreamDeleted
                     | InvalidTransaction
                     deriving (Prelude'.Read, Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable OperationResult
 
instance Prelude'.Bounded OperationResult where
  minBound = Success
  maxBound = InvalidTransaction
 
instance P'.Default OperationResult where
  defaultValue = Success
 
toMaybe'Enum :: Prelude'.Int -> P'.Maybe OperationResult
toMaybe'Enum 0 = Prelude'.Just Success
toMaybe'Enum 1 = Prelude'.Just PrepareTimeout
toMaybe'Enum 2 = Prelude'.Just CommitTimeout
toMaybe'Enum 3 = Prelude'.Just ForwardTimeout
toMaybe'Enum 4 = Prelude'.Just WrongExpectedVersion
toMaybe'Enum 5 = Prelude'.Just StreamDeleted
toMaybe'Enum 6 = Prelude'.Just InvalidTransaction
toMaybe'Enum _ = Prelude'.Nothing
 
instance Prelude'.Enum OperationResult where
  fromEnum Success = 0
  fromEnum PrepareTimeout = 1
  fromEnum CommitTimeout = 2
  fromEnum ForwardTimeout = 3
  fromEnum WrongExpectedVersion = 4
  fromEnum StreamDeleted = 5
  fromEnum InvalidTransaction = 6
  toEnum
   = P'.fromMaybe (Prelude'.error "hprotoc generated code: toEnum failure for type HES.Messages.OperationResult") . toMaybe'Enum
  succ Success = PrepareTimeout
  succ PrepareTimeout = CommitTimeout
  succ CommitTimeout = ForwardTimeout
  succ ForwardTimeout = WrongExpectedVersion
  succ WrongExpectedVersion = StreamDeleted
  succ StreamDeleted = InvalidTransaction
  succ _ = Prelude'.error "hprotoc generated code: succ failure for type HES.Messages.OperationResult"
  pred PrepareTimeout = Success
  pred CommitTimeout = PrepareTimeout
  pred ForwardTimeout = CommitTimeout
  pred WrongExpectedVersion = ForwardTimeout
  pred StreamDeleted = WrongExpectedVersion
  pred InvalidTransaction = StreamDeleted
  pred _ = Prelude'.error "hprotoc generated code: pred failure for type HES.Messages.OperationResult"
 
instance P'.Wire OperationResult where
  wireSize ft' enum = P'.wireSize ft' (Prelude'.fromEnum enum)
  wirePut ft' enum = P'.wirePut ft' (Prelude'.fromEnum enum)
  wireGet 14 = P'.wireGetEnum toMaybe'Enum
  wireGet ft' = P'.wireGetErr ft'
  wireGetPacked 14 = P'.wireGetPackedEnum toMaybe'Enum
  wireGetPacked ft' = P'.wireGetErr ft'
 
instance P'.GPB OperationResult
 
instance P'.MessageAPI msg' (msg' -> OperationResult) OperationResult where
  getVal m' f' = f' m'
 
instance P'.ReflectEnum OperationResult where
  reflectEnum
   = [(0, "Success", Success), (1, "PrepareTimeout", PrepareTimeout), (2, "CommitTimeout", CommitTimeout),
      (3, "ForwardTimeout", ForwardTimeout), (4, "WrongExpectedVersion", WrongExpectedVersion), (5, "StreamDeleted", StreamDeleted),
      (6, "InvalidTransaction", InvalidTransaction)]
  reflectEnumInfo _
   = P'.EnumInfo (P'.makePNF (P'.pack ".HES.Messages.OperationResult") [] ["HES", "Messages"] "OperationResult")
      ["HES", "Messages", "OperationResult.hs"]
      [(0, "Success"), (1, "PrepareTimeout"), (2, "CommitTimeout"), (3, "ForwardTimeout"), (4, "WrongExpectedVersion"),
       (5, "StreamDeleted"), (6, "InvalidTransaction")]