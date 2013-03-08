{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.WriteEvents (WriteEvents(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified HES.Messages.NewEvent as HES.Messages (NewEvent)
 
data WriteEvents = WriteEvents{event_stream_id :: !P'.Utf8, expected_version :: !P'.Int32,
                               events :: !(P'.Seq HES.Messages.NewEvent), allow_forwarding :: !P'.Bool}
                 deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable WriteEvents where
  mergeAppend (WriteEvents x'1 x'2 x'3 x'4) (WriteEvents y'1 y'2 y'3 y'4)
   = WriteEvents (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
 
instance P'.Default WriteEvents where
  defaultValue = WriteEvents P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire WriteEvents where
  wireSize ft' self'@(WriteEvents x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 9 x'1 + P'.wireSizeReq 1 5 x'2 + P'.wireSizeRep 1 11 x'3 + P'.wireSizeReq 1 8 x'4)
  wirePut ft' self'@(WriteEvents x'1 x'2 x'3 x'4)
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
             P'.wirePutRep 26 11 x'3
             P'.wirePutReq 32 8 x'4
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{event_stream_id = new'Field}) (P'.wireGet 9)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{expected_version = new'Field}) (P'.wireGet 5)
             26 -> Prelude'.fmap (\ !new'Field -> old'Self{events = P'.append (events old'Self) new'Field}) (P'.wireGet 11)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{allow_forwarding = new'Field}) (P'.wireGet 8)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> WriteEvents) WriteEvents where
  getVal m' f' = f' m'
 
instance P'.GPB WriteEvents
 
instance P'.ReflectDescriptor WriteEvents where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 16, 32]) (P'.fromDistinctAscList [10, 16, 26, 32])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.WriteEvents\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"WriteEvents\"}, descFilePath = [\"HES\",\"Messages\",\"WriteEvents.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.WriteEvents.event_stream_id\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"WriteEvents\"], baseName' = FName \"event_stream_id\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.WriteEvents.expected_version\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"WriteEvents\"], baseName' = FName \"expected_version\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.WriteEvents.events\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"WriteEvents\"], baseName' = FName \"events\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 26}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.NewEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"NewEvent\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.WriteEvents.allow_forwarding\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"WriteEvents\"], baseName' = FName \"allow_forwarding\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 8}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"