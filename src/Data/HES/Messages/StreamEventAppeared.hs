{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.StreamEventAppeared (StreamEventAppeared(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified Data.HES.Messages.ResolvedEvent as HES.Messages (ResolvedEvent)
 
data StreamEventAppeared = StreamEventAppeared{event :: !HES.Messages.ResolvedEvent}
                         deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable StreamEventAppeared where
  mergeAppend (StreamEventAppeared x'1) (StreamEventAppeared y'1) = StreamEventAppeared (P'.mergeAppend x'1 y'1)
 
instance P'.Default StreamEventAppeared where
  defaultValue = StreamEventAppeared P'.defaultValue
 
instance P'.Wire StreamEventAppeared where
  wireSize ft' self'@(StreamEventAppeared x'1)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 11 x'1)
  wirePut ft' self'@(StreamEventAppeared x'1)
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
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{event = P'.mergeAppend (event old'Self) (new'Field)}) (P'.wireGet 11)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> StreamEventAppeared) StreamEventAppeared where
  getVal m' f' = f' m'
 
instance P'.GPB StreamEventAppeared
 
instance P'.ReflectDescriptor StreamEventAppeared where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10]) (P'.fromDistinctAscList [10])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.StreamEventAppeared\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"StreamEventAppeared\"}, descFilePath = [\"HES\",\"Messages\",\"StreamEventAppeared.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.StreamEventAppeared.event\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"StreamEventAppeared\"], baseName' = FName \"event\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".HES.Messages.ResolvedEvent\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"ResolvedEvent\"}), hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"