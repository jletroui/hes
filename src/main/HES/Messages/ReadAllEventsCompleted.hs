{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ReadAllEventsCompleted (ReadAllEventsCompleted(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified HES.Messages.ResolvedEvent as HES.Messages (ResolvedEvent)
 
data ReadAllEventsCompleted = ReadAllEventsCompleted{commit_position :: !P'.Int64, prepare_position :: !P'.Int64,
                                                     events :: !(P'.Seq HES.Messages.ResolvedEvent),
                                                     next_commit_position :: !P'.Int64, next_prepare_position :: !P'.Int64}
                            deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadAllEventsCompleted where
  mergeAppend (ReadAllEventsCompleted x'1 x'2 x'3 x'4 x'5) (ReadAllEventsCompleted y'1 y'2 y'3 y'4 y'5)
   = ReadAllEventsCompleted (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
      (P'.mergeAppend x'5 y'5)
 
instance P'.Default ReadAllEventsCompleted where
  defaultValue = ReadAllEventsCompleted P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire ReadAllEventsCompleted where
  wireSize ft' self'@(ReadAllEventsCompleted x'1 x'2 x'3 x'4 x'5)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size
         = (P'.wireSizeReq 1 3 x'1 + P'.wireSizeReq 1 3 x'2 + P'.wireSizeRep 1 11 x'3 + P'.wireSizeReq 1 3 x'4 +
             P'.wireSizeReq 1 3 x'5)
  wirePut ft' self'@(ReadAllEventsCompleted x'1 x'2 x'3 x'4 x'5)
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
             P'.wirePutRep 26 11 x'3
             P'.wirePutReq 32 3 x'4
             P'.wirePutReq 40 3 x'5
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
             26 -> Prelude'.fmap (\ !new'Field -> old'Self{events = P'.append (events old'Self) new'Field}) (P'.wireGet 11)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{next_commit_position = new'Field}) (P'.wireGet 3)
             40 -> Prelude'.fmap (\ !new'Field -> old'Self{next_prepare_position = new'Field}) (P'.wireGet 3)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ReadAllEventsCompleted) ReadAllEventsCompleted where
  getVal m' f' = f' m'
 
instance P'.GPB ReadAllEventsCompleted
 
instance P'.ReflectDescriptor ReadAllEventsCompleted where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [8, 16, 32, 40]) (P'.fromDistinctAscList [8, 16, 26, 32, 40])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ReadAllEventsCompleted\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ReadAllEventsCompleted\"}, descFilePath = [\"HES\",\"Messages\",\"ReadAllEventsCompleted.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEventsCompleted.commit_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEventsCompleted\"], baseName' = FName \"commit_position\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEventsCompleted.prepare_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEventsCompleted\"], baseName' = FName \"prepare_position\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEventsCompleted.events\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEventsCompleted\"], baseName' = FName \"events\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 26}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.ResolvedEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ResolvedEvent\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEventsCompleted.next_commit_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEventsCompleted\"], baseName' = FName \"next_commit_position\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadAllEventsCompleted.next_prepare_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadAllEventsCompleted\"], baseName' = FName \"next_prepare_position\"}, fieldNumber = FieldId {getFieldId = 5}, wireTag = WireTag {getWireTag = 40}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"