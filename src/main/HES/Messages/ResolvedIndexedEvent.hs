{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ResolvedIndexedEvent (ResolvedIndexedEvent(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified HES.Messages.EventRecord as HES.Messages (EventRecord)
 
data ResolvedIndexedEvent = ResolvedIndexedEvent{event :: !HES.Messages.EventRecord, link :: !(P'.Maybe HES.Messages.EventRecord)}
                          deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ResolvedIndexedEvent where
  mergeAppend (ResolvedIndexedEvent x'1 x'2) (ResolvedIndexedEvent y'1 y'2)
   = ResolvedIndexedEvent (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2)
 
instance P'.Default ResolvedIndexedEvent where
  defaultValue = ResolvedIndexedEvent P'.defaultValue P'.defaultValue
 
instance P'.Wire ResolvedIndexedEvent where
  wireSize ft' self'@(ResolvedIndexedEvent x'1 x'2)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 11 x'1 + P'.wireSizeOpt 1 11 x'2)
  wirePut ft' self'@(ResolvedIndexedEvent x'1 x'2)
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
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ResolvedIndexedEvent) ResolvedIndexedEvent where
  getVal m' f' = f' m'
 
instance P'.GPB ResolvedIndexedEvent
 
instance P'.ReflectDescriptor ResolvedIndexedEvent where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10]) (P'.fromDistinctAscList [10, 18])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ResolvedIndexedEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ResolvedIndexedEvent\"}, descFilePath = [\"HES\",\"Messages\",\"ResolvedIndexedEvent.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ResolvedIndexedEvent.event\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ResolvedIndexedEvent\"], baseName' = FName \"event\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.EventRecord\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"EventRecord\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ResolvedIndexedEvent.link\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ResolvedIndexedEvent\"], baseName' = FName \"link\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.EventRecord\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"EventRecord\"}), hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"