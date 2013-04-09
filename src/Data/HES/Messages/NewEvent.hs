{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.NewEvent (NewEvent(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data NewEvent = NewEvent{event_id :: !P'.ByteString, event_type :: !(P'.Maybe P'.Utf8), is_json :: !P'.Bool,
                         data' :: !P'.ByteString, metadata :: !(P'.Maybe P'.ByteString)}
              deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable NewEvent where
  mergeAppend (NewEvent x'1 x'2 x'3 x'4 x'5) (NewEvent y'1 y'2 y'3 y'4 y'5)
   = NewEvent (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
      (P'.mergeAppend x'5 y'5)
 
instance P'.Default NewEvent where
  defaultValue = NewEvent P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire NewEvent where
  wireSize ft' self'@(NewEvent x'1 x'2 x'3 x'4 x'5)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size
         = (P'.wireSizeReq 1 12 x'1 + P'.wireSizeOpt 1 9 x'2 + P'.wireSizeReq 1 8 x'3 + P'.wireSizeReq 1 12 x'4 +
             P'.wireSizeOpt 1 12 x'5)
  wirePut ft' self'@(NewEvent x'1 x'2 x'3 x'4 x'5)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutReq 10 12 x'1
             P'.wirePutOpt 18 9 x'2
             P'.wirePutReq 24 8 x'3
             P'.wirePutReq 34 12 x'4
             P'.wirePutOpt 42 12 x'5
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{event_id = new'Field}) (P'.wireGet 12)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{event_type = Prelude'.Just new'Field}) (P'.wireGet 9)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{is_json = new'Field}) (P'.wireGet 8)
             34 -> Prelude'.fmap (\ !new'Field -> old'Self{data' = new'Field}) (P'.wireGet 12)
             42 -> Prelude'.fmap (\ !new'Field -> old'Self{metadata = Prelude'.Just new'Field}) (P'.wireGet 12)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> NewEvent) NewEvent where
  getVal m' f' = f' m'
 
instance P'.GPB NewEvent
 
instance P'.ReflectDescriptor NewEvent where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 24, 34]) (P'.fromDistinctAscList [10, 18, 24, 34, 42])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.NewEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"NewEvent\"}, descFilePath = [\"HES\",\"Messages\",\"NewEvent.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.NewEvent.event_id\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"NewEvent\"], baseName' = FName \"event_id\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.NewEvent.event_type\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"NewEvent\"], baseName' = FName \"event_type\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.NewEvent.is_json\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"NewEvent\"], baseName' = FName \"is_json\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 8}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.NewEvent.data\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"NewEvent\"], baseName' = FName \"data'\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 34}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.NewEvent.metadata\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"NewEvent\"], baseName' = FName \"metadata\"}, fieldNumber = FieldId {getFieldId = 5}, wireTag = WireTag {getWireTag = 42}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"