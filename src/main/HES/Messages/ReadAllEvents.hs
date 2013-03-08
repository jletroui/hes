{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ReadAllEvents (ReadAllEvents(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data ReadAllEvents = ReadAllEvents{commit_position :: !P'.Int64, prepare_position :: !P'.Int64, max_count :: !P'.Int32,
                                   resolve_link_tos :: !P'.Bool}
                   deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadAllEvents where
  mergeAppend (ReadAllEvents x'1 x'2 x'3 x'4) (ReadAllEvents y'1 y'2 y'3 y'4)
   = ReadAllEvents (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
 
instance P'.Default ReadAllEvents where
  defaultValue = ReadAllEvents P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire ReadAllEvents where
  wireSize ft' self'@(ReadAllEvents x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 3 x'1 + P'.wireSizeReq 1 3 x'2 + P'.wireSizeReq 1 5 x'3 + P'.wireSizeReq 1 8 x'4)
  wirePut ft' self'@(ReadAllEvents x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutReq 8 3 x'1
             P'.wirePutReq 16 3 x'2
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
             8 -> Prelude'.fmap (\ !new'Field -> old'Self{commit_position = new'Field}) (P'.wireGet 3)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{prepare_position = new'Field}) (P'.wireGet 3)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{max_count = new'Field}) (P'.wireGet 5)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{resolve_link_tos = new'Field}) (P'.wireGet 8)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ReadAllEvents) ReadAllEvents where
  getVal m' f' = f' m'
 
instance P'.GPB ReadAllEvents
 
instance P'.ReflectDescriptor ReadAllEvents where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [8, 16, 24, 32]) (P'.fromDistinctAscList [8, 16, 24, 32])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ReadAllEvents\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ReadAllEvents\"}, descFilePath = [\"HES\",\"Messages\",\"ReadAllEvents.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEvents.commit_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEvents\"], baseName' = FName \"commit_position\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEvents.prepare_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEvents\"], baseName' = FName \"prepare_position\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEvents.max_count\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEvents\"], baseName' = FName \"max_count\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEvents.resolve_link_tos\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEvents\"], baseName' = FName \"resolve_link_tos\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 8}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"