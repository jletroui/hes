{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module HES.Messages.UnsubscribeFromStream (UnsubscribeFromStream(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data UnsubscribeFromStream = UnsubscribeFromStream{}
                           deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable UnsubscribeFromStream where
  mergeAppend UnsubscribeFromStream UnsubscribeFromStream = UnsubscribeFromStream
 
instance P'.Default UnsubscribeFromStream where
  defaultValue = UnsubscribeFromStream
 
instance P'.Wire UnsubscribeFromStream where
  wireSize ft' self'@(UnsubscribeFromStream)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = 0
  wirePut ft' self'@(UnsubscribeFromStream)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             Prelude'.return ()
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> UnsubscribeFromStream) UnsubscribeFromStream where
  getVal m' f' = f' m'
 
instance P'.GPB UnsubscribeFromStream
 
instance P'.ReflectDescriptor UnsubscribeFromStream where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList []) (P'.fromDistinctAscList [])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.UnsubscribeFromStream\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"UnsubscribeFromStream\"}, descFilePath = [\"HES\",\"Messages\",\"UnsubscribeFromStream.hs\"], isGroup = False, fields = fromList [], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"