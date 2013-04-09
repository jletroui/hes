{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.ReadStreamEvents (ReadStreamEvents(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data ReadStreamEvents = ReadStreamEvents{event_stream_id :: !P'.Utf8, from_event_number :: !P'.Int32, max_count :: !P'.Int32,
                                         resolve_link_tos :: !P'.Bool}
                      deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadStreamEvents where
  mergeAppend (ReadStreamEvents x'1 x'2 x'3 x'4) (ReadStreamEvents y'1 y'2 y'3 y'4)
   = ReadStreamEvents (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
 
instance P'.Default ReadStreamEvents where
  defaultValue = ReadStreamEvents P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire ReadStreamEvents where
  wireSize ft' self'@(ReadStreamEvents x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 9 x'1 + P'.wireSizeReq 1 5 x'2 + P'.wireSizeReq 1 5 x'3 + P'.wireSizeReq 1 8 x'4)
  wirePut ft' self'@(ReadStreamEvents x'1 x'2 x'3 x'4)
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
             P'.wirePutReq 24 5 x'3
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
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{from_event_number = new'Field}) (P'.wireGet 5)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{max_count = new'Field}) (P'.wireGet 5)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{resolve_link_tos = new'Field}) (P'.wireGet 8)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ReadStreamEvents) ReadStreamEvents where
  getVal m' f' = f' m'
 
instance P'.GPB ReadStreamEvents
 
instance P'.ReflectDescriptor ReadStreamEvents where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 16, 24, 32]) (P'.fromDistinctAscList [10, 16, 24, 32])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ReadStreamEvents\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ReadStreamEvents\"}, descFilePath = [\"HES\",\"Messages\",\"ReadStreamEvents.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEvents.event_stream_id\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEvents\"], baseName' = FName \"event_stream_id\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEvents.from_event_number\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEvents\"], baseName' = FName \"from_event_number\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEvents.max_count\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEvents\"], baseName' = FName \"max_count\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadStreamEvents.resolve_link_tos\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadStreamEvents\"], baseName' = FName \"resolve_link_tos\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 8}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"