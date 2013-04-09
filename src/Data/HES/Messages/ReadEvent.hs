{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.ReadEvent (ReadEvent(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data ReadEvent = ReadEvent{event_stream_id :: !P'.Utf8, event_number :: !P'.Int32, resolve_link_tos :: !P'.Bool}
               deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadEvent where
  mergeAppend (ReadEvent x'1 x'2 x'3) (ReadEvent y'1 y'2 y'3)
   = ReadEvent (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3)
 
instance P'.Default ReadEvent where
  defaultValue = ReadEvent P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire ReadEvent where
  wireSize ft' self'@(ReadEvent x'1 x'2 x'3)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 9 x'1 + P'.wireSizeReq 1 5 x'2 + P'.wireSizeReq 1 8 x'3)
  wirePut ft' self'@(ReadEvent x'1 x'2 x'3)
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
             P'.wirePutReq 24 8 x'3
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
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{resolve_link_tos = new'Field}) (P'.wireGet 8)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ReadEvent) ReadEvent where
  getVal m' f' = f' m'
 
instance P'.GPB ReadEvent
 
instance P'.ReflectDescriptor ReadEvent where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 16, 24]) (P'.fromDistinctAscList [10, 16, 24])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ReadEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ReadEvent\"}, descFilePath = [\"HES\",\"Messages\",\"ReadEvent.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadEvent.event_stream_id\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadEvent\"], baseName' = FName \"event_stream_id\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadEvent.event_number\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadEvent\"], baseName' = FName \"event_number\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadEvent.resolve_link_tos\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadEvent\"], baseName' = FName \"resolve_link_tos\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 8}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"