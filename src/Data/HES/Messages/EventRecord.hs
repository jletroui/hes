{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.EventRecord (EventRecord(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data EventRecord = EventRecord{event_stream_id :: !P'.Utf8, event_number :: !P'.Int32, event_id :: !P'.ByteString,
                               event_type :: !(P'.Maybe P'.Utf8), data' :: !P'.ByteString, metadata :: !(P'.Maybe P'.ByteString)}
                 deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable EventRecord where
  mergeAppend (EventRecord x'1 x'2 x'3 x'4 x'5 x'6) (EventRecord y'1 y'2 y'3 y'4 y'5 y'6)
   = EventRecord (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
      (P'.mergeAppend x'5 y'5)
      (P'.mergeAppend x'6 y'6)
 
instance P'.Default EventRecord where
  defaultValue = EventRecord P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire EventRecord where
  wireSize ft' self'@(EventRecord x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size
         = (P'.wireSizeReq 1 9 x'1 + P'.wireSizeReq 1 5 x'2 + P'.wireSizeReq 1 12 x'3 + P'.wireSizeOpt 1 9 x'4 +
             P'.wireSizeReq 1 12 x'5
             + P'.wireSizeOpt 1 12 x'6)
  wirePut ft' self'@(EventRecord x'1 x'2 x'3 x'4 x'5 x'6)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutReq 10 9 x'1
             P'.wirePutReq 16 5 x'2
             P'.wirePutReq 26 12 x'3
             P'.wirePutOpt 34 9 x'4
             P'.wirePutReq 42 12 x'5
             P'.wirePutOpt 50 12 x'6
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{event_stream_id = new'Field}) (P'.wireGet 9)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{event_number = new'Field}) (P'.wireGet 5)
             26 -> Prelude'.fmap (\ !new'Field -> old'Self{event_id = new'Field}) (P'.wireGet 12)
             34 -> Prelude'.fmap (\ !new'Field -> old'Self{event_type = Prelude'.Just new'Field}) (P'.wireGet 9)
             42 -> Prelude'.fmap (\ !new'Field -> old'Self{data' = new'Field}) (P'.wireGet 12)
             50 -> Prelude'.fmap (\ !new'Field -> old'Self{metadata = Prelude'.Just new'Field}) (P'.wireGet 12)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> EventRecord) EventRecord where
  getVal m' f' = f' m'
 
instance P'.GPB EventRecord
 
instance P'.ReflectDescriptor EventRecord where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 16, 26, 42]) (P'.fromDistinctAscList [10, 16, 26, 34, 42, 50])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.EventRecord\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"EventRecord\"}, descFilePath = [\"HES\",\"Messages\",\"EventRecord.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.EventRecord.event_stream_id\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"EventRecord\"], baseName' = FName \"event_stream_id\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.EventRecord.event_number\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"EventRecord\"], baseName' = FName \"event_number\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.EventRecord.event_id\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"EventRecord\"], baseName' = FName \"event_id\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 26}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.EventRecord.event_type\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"EventRecord\"], baseName' = FName \"event_type\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 34}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.EventRecord.data\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"EventRecord\"], baseName' = FName \"data'\"}, fieldNumber = FieldId {getFieldId = 5}, wireTag = WireTag {getWireTag = 42}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.EventRecord.metadata\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"EventRecord\"], baseName' = FName \"metadata\"}, fieldNumber = FieldId {getFieldId = 6}, wireTag = WireTag {getWireTag = 50}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"