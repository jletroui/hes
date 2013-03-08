{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.DeleteStreamCompleted (DeleteStreamCompleted(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified HES.Messages.OperationResult as HES.Messages (OperationResult)
 
data DeleteStreamCompleted = DeleteStreamCompleted{result :: !HES.Messages.OperationResult, message :: !(P'.Maybe P'.Utf8)}
                           deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable DeleteStreamCompleted where
  mergeAppend (DeleteStreamCompleted x'1 x'2) (DeleteStreamCompleted y'1 y'2)
   = DeleteStreamCompleted (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2)
 
instance P'.Default DeleteStreamCompleted where
  defaultValue = DeleteStreamCompleted P'.defaultValue P'.defaultValue
 
instance P'.Wire DeleteStreamCompleted where
  wireSize ft' self'@(DeleteStreamCompleted x'1 x'2)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 14 x'1 + P'.wireSizeOpt 1 9 x'2)
  wirePut ft' self'@(DeleteStreamCompleted x'1 x'2)
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
             P'.wirePutOpt 18 9 x'2
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             8 -> Prelude'.fmap (\ !new'Field -> old'Self{result = new'Field}) (P'.wireGet 14)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{message = Prelude'.Just new'Field}) (P'.wireGet 9)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> DeleteStreamCompleted) DeleteStreamCompleted where
  getVal m' f' = f' m'
 
instance P'.GPB DeleteStreamCompleted
 
instance P'.ReflectDescriptor DeleteStreamCompleted where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [8]) (P'.fromDistinctAscList [8, 18])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.DeleteStreamCompleted\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"DeleteStreamCompleted\"}, descFilePath = [\"HES\",\"Messages\",\"DeleteStreamCompleted.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.DeleteStreamCompleted.result\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"DeleteStreamCompleted\"], baseName' = FName \"result\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 14}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.OperationResult\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"OperationResult\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.DeleteStreamCompleted.message\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"DeleteStreamCompleted\"], baseName' = FName \"message\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"