{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ResolvedEvent (ResolvedEvent(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified HES.Messages.EventRecord as HES.Messages (EventRecord)
 
data ResolvedEvent = ResolvedEvent{event :: !HES.Messages.EventRecord, link :: !(P'.Maybe HES.Messages.EventRecord),
                                   commit_position :: !P'.Int64, prepare_position :: !P'.Int64}
                   deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ResolvedEvent where
  mergeAppend (ResolvedEvent x'1 x'2 x'3 x'4) (ResolvedEvent y'1 y'2 y'3 y'4)
   = ResolvedEvent (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
 
instance P'.Default ResolvedEvent where
  defaultValue = ResolvedEvent P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire ResolvedEvent where
  wireSize ft' self'@(ResolvedEvent x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 11 x'1 + P'.wireSizeOpt 1 11 x'2 + P'.wireSizeReq 1 3 x'3 + P'.wireSizeReq 1 3 x'4)
  wirePut ft' self'@(ResolvedEvent x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutReq 10 11 x'1
             P'.wirePutOpt 18 11 x'2
             P'.wirePutReq 24 3 x'3
             P'.wirePutReq 32 3 x'4
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{event = P'.mergeAppend (event old'Self) (new'Field)}) (P'.wireGet 11)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{link = P'.mergeAppend (link old'Self) (Prelude'.Just new'Field)})
                    (P'.wireGet 11)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{commit_position = new'Field}) (P'.wireGet 3)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{prepare_position = new'Field}) (P'.wireGet 3)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ResolvedEvent) ResolvedEvent where
  getVal m' f' = f' m'
 
instance P'.GPB ResolvedEvent
 
instance P'.ReflectDescriptor ResolvedEvent where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 24, 32]) (P'.fromDistinctAscList [10, 18, 24, 32])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ResolvedEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ResolvedEvent\"}, descFilePath = [\"HES\",\"Messages\",\"ResolvedEvent.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ResolvedEvent.event\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ResolvedEvent\"], baseName' = FName \"event\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.EventRecord\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"EventRecord\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ResolvedEvent.link\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ResolvedEvent\"], baseName' = FName \"link\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.EventRecord\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"EventRecord\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ResolvedEvent.commit_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ResolvedEvent\"], baseName' = FName \"commit_position\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ResolvedEvent.prepare_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ResolvedEvent\"], baseName' = FName \"prepare_position\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"