{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.ReadEventCompleted (ReadEventCompleted(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified HES.Messages.ReadEventCompleted.ReadEventResult as HES.Messages.ReadEventCompleted (ReadEventResult)
import qualified HES.Messages.ResolvedIndexedEvent as HES.Messages (ResolvedIndexedEvent)
 
data ReadEventCompleted = ReadEventCompleted{result :: !HES.Messages.ReadEventCompleted.ReadEventResult,
                                             event :: !HES.Messages.ResolvedIndexedEvent}
                        deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable ReadEventCompleted where
  mergeAppend (ReadEventCompleted x'1 x'2) (ReadEventCompleted y'1 y'2)
   = ReadEventCompleted (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2)
 
instance P'.Default ReadEventCompleted where
  defaultValue = ReadEventCompleted P'.defaultValue P'.defaultValue
 
instance P'.Wire ReadEventCompleted where
  wireSize ft' self'@(ReadEventCompleted x'1 x'2)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 14 x'1 + P'.wireSizeReq 1 11 x'2)
  wirePut ft' self'@(ReadEventCompleted x'1 x'2)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutReq 8 14 x'1
             P'.wirePutReq 18 11 x'2
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             8 -> Prelude'.fmap (\ !new'Field -> old'Self{result = new'Field}) (P'.wireGet 14)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{event = P'.mergeAppend (event old'Self) (new'Field)}) (P'.wireGet 11)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> ReadEventCompleted) ReadEventCompleted where
  getVal m' f' = f' m'
 
instance P'.GPB ReadEventCompleted
 
instance P'.ReflectDescriptor ReadEventCompleted where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [8, 18]) (P'.fromDistinctAscList [8, 18])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.ReadEventCompleted\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ReadEventCompleted\"}, descFilePath = [\"HES\",\"Messages\",\"ReadEventCompleted.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadEventCompleted.result\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadEventCompleted\"], baseName' = FName \"result\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 14}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.ReadEventCompleted.ReadEventResult\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\",MName \"ReadEventCompleted\"], baseName = MName \"ReadEventResult\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.ReadEventCompleted.event\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"ReadEventCompleted\"], baseName' = FName \"event\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.ResolvedIndexedEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ResolvedIndexedEvent\"}), hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"