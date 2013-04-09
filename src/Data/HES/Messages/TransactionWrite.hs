{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.TransactionWrite (TransactionWrite(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified Data.HES.Messages.NewEvent as HES.Messages (NewEvent)
 
data TransactionWrite = TransactionWrite{transaction_id :: !P'.Int64, events :: !(P'.Seq HES.Messages.NewEvent),
                                         allow_forwarding :: !P'.Bool}
                      deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable TransactionWrite where
  mergeAppend (TransactionWrite x'1 x'2 x'3) (TransactionWrite y'1 y'2 y'3)
   = TransactionWrite (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3)
 
instance P'.Default TransactionWrite where
  defaultValue = TransactionWrite P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire TransactionWrite where
  wireSize ft' self'@(TransactionWrite x'1 x'2 x'3)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 3 x'1 + P'.wireSizeRep 1 11 x'2 + P'.wireSizeReq 1 8 x'3)
  wirePut ft' self'@(TransactionWrite x'1 x'2 x'3)
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
             P'.wirePutRep 18 11 x'2
             P'.wirePutReq 24 8 x'3
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             8 -> Prelude'.fmap (\ !new'Field -> old'Self{transaction_id = new'Field}) (P'.wireGet 3)
             18 -> Prelude'.fmap (\ !new'Field -> old'Self{events = P'.append (events old'Self) new'Field}) (P'.wireGet 11)
             24 -> Prelude'.fmap (\ !new'Field -> old'Self{allow_forwarding = new'Field}) (P'.wireGet 8)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> TransactionWrite) TransactionWrite where
  getVal m' f' = f' m'
 
instance P'.GPB TransactionWrite
 
instance P'.ReflectDescriptor TransactionWrite where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [8, 24]) (P'.fromDistinctAscList [8, 18, 24])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.TransactionWrite\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"TransactionWrite\"}, descFilePath = [\"HES\",\"Messages\",\"TransactionWrite.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.TransactionWrite.transaction_id\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"TransactionWrite\"], baseName' = FName \"transaction_id\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.TransactionWrite.events\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"TransactionWrite\"], baseName' = FName \"events\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 18}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.NewEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"NewEvent\"}), hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.TransactionWrite.allow_forwarding\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"TransactionWrite\"], baseName' = FName \"allow_forwarding\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 24}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 8}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"