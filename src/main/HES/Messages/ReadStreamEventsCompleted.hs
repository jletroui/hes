{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ReadStreamEventsCompleted (ReadStreamEventsCompleted(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified HES.Messages.ReadStreamEventsCompleted.ReadStreamResult as HES.Messages.ReadStreamEventsCompleted
       (ReadStreamResult)
import qualified HES.Messages.ResolvedIndexedEvent as HES.Messages (ResolvedIndexedEvent)
 
data ReadStreamEventsCompleted = ReadStreamEventsCompleted{events :: !(P'.Seq HES.Messages.ResolvedIndexedEvent),
                                                           result :: !HES.Messages.ReadStreamEventsCompleted.ReadStreamResult,
                                                           next_event_number :: !P'.Int32, last_event_number :: !P'.Int32,
                                                           is_end_of_stream :: !P'.Bool, last_commit_position :: !P'.Int64}
                               deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadStreamEventsCompleted where
  mergeAppend (ReadStreamEventsCompleted x'1 x'2 x'3 x'4 x'5 x'6) (ReadStreamEventsCompleted y'1 y'2 y'3 y'4 y'5 y'6)
   = ReadStreamEventsCompleted (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
      (P'.mergeAppend x'5 y'5)
      (P'.mergeAppend x'6 y'6)
 
instance P'.Default ReadStreamEventsCompleted where
  defaultValue
   = ReadStreamEventsCompleted P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire ReadStreamEventsCompleted where
  wireSize ft' self'@(ReadStreamEventsCompleted x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size
         = (P'.wireSizeRep 1 11 x'1 + P'.wireSizeReq 1 14 x'2 + P'.wireSizeReq 1 5 x'3 + P'.wireSizeReq 1 5 x'4 +
             P'.wireSizeReq 1 8 x'5
             + P'.wireSizeReq 1 3 x'6)
  wirePut ft' self'@(ReadStreamEventsCompleted x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutRep 10 11 x'1
             P'.wirePutReq 16 14 x'2
             P'.wirePutReq 24 5 x'3
             P'.wirePutReq 32 5 x'4
             P'.wirePutReq 40 8 x'5
             P'.wirePutReq 48 3 x'6
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{events = P'.append (events old'Self) new'Field}) (P'.wireGet 11)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{result = new'Field}) (P'.wireGet 14)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{next_event_number = new'Field}) (P'.wireGet 5)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{last_event_number = new'Field}) (P'.wireGet 5)
             40 -> Prelude'.fmap (\ !new'Field -> old'Self{is_end_of_stream = new'Field}) (P'.wireGet 8)
             48 -> Prelude'.fmap (\ !new'Field -> old'Self{last_commit_position = new'Field}) (P'.wireGet 3)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ReadStreamEventsCompleted) ReadStreamEventsCompleted where
  getVal m' f' = f' m'
 
instance P'.GPB ReadStreamEventsCompleted
 
instance P'.ReflectDescriptor ReadStreamEventsCompleted where
  getMessageInfo _
   = P'.GetMessageInfo (P'.fromDistinctAscList [16, 24, 32, 40, 48]) (P'.fromDistinctAscList [10, 16, 24, 32, 40, 48])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ReadStreamEventsCompleted\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ReadStreamEventsCompleted\"}, descFilePath = [\"HES\",\"Messages\",\"ReadStreamEventsCompleted.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEventsCompleted.events\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEventsCompleted\"], baseName' = FName \"events\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.ResolvedIndexedEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ResolvedIndexedEvent\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEventsCompleted.result\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEventsCompleted\"], baseName' = FName \"result\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 14}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.ReadStreamEventsCompleted.ReadStreamResult\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEventsCompleted\"], baseName = MName \"ReadStreamResult\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEventsCompleted.next_event_number\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEventsCompleted\"], baseName' = FName \"next_event_number\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEventsCompleted.last_event_number\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEventsCompleted\"], baseName' = FName \"last_event_number\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEventsCompleted.is_end_of_stream\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEventsCompleted\"], baseName' = FName \"is_end_of_stream\"}, fieldNumber = FieldId {getFieldId = 5}, wireTag = WireTag {getWireTag = 40}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 8}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEventsCompleted.last_commit_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEventsCompleted\"], baseName' = FName \"last_commit_position\"}, fieldNumber = FieldId {getFieldId = 6}, wireTag = WireTag {getWireTag = 48}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"