{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.SubscriptionConfirmation (SubscriptionConfirmation(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data SubscriptionConfirmation = SubscriptionConfirmation{last_commit_position :: !P'.Int64,
                                                         last_event_number :: !(P'.Maybe P'.Int32)}
                              deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable SubscriptionConfirmation where
  mergeAppend (SubscriptionConfirmation x'1 x'2) (SubscriptionConfirmation y'1 y'2)
   = SubscriptionConfirmation (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2)
 
instance P'.Default SubscriptionConfirmation where
  defaultValue = SubscriptionConfirmation P'.defaultValue P'.defaultValue
 
instance P'.Wire SubscriptionConfirmation where
  wireSize ft' self'@(SubscriptionConfirmation x'1 x'2)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 3 x'1 + P'.wireSizeOpt 1 5 x'2)
  wirePut ft' self'@(SubscriptionConfirmation x'1 x'2)
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
             P'.wirePutOpt 16 5 x'2
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             8 -> Prelude'.fmap (\ !new'Field -> old'Self{last_commit_position = new'Field}) (P'.wireGet 3)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{last_event_number = Prelude'.Just new'Field}) (P'.wireGet 5)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> SubscriptionConfirmation) SubscriptionConfirmation where
  getVal m' f' = f' m'
 
instance P'.GPB SubscriptionConfirmation
 
instance P'.ReflectDescriptor SubscriptionConfirmation where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [8]) (P'.fromDistinctAscList [8, 16])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.SubscriptionConfirmation\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"SubscriptionConfirmation\"}, descFilePath = [\"HES\",\"Messages\",\"SubscriptionConfirmation.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.SubscriptionConfirmation.last_commit_position\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"SubscriptionConfirmation\"], baseName' = FName \"last_commit_position\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 8}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 3}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.SubscriptionConfirmation.last_event_number\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"SubscriptionConfirmation\"], baseName' = FName \"last_event_number\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"