{-# LANGUAGE BangPatterns, DeriveDataTypeable, FlexibleInstances, MultiParamTypeClasses #-}
module Data.HES.Messages.DeniedToRoute (DeniedToRoute(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
 
data DeniedToRoute = DeniedToRoute{external_tcp_address :: !P'.Utf8, external_tcp_port :: !P'.Int32,
                                   external_http_address :: !P'.Utf8, external_http_port :: !P'.Int32}
                   deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data)
 
instance P'.Mergeable DeniedToRoute where
  mergeAppend (DeniedToRoute x'1 x'2 x'3 x'4) (DeniedToRoute y'1 y'2 y'3 y'4)
   = DeniedToRoute (P'.mergeAppend x'1 y'1) (P'.mergeAppend x'2 y'2) (P'.mergeAppend x'3 y'3) (P'.mergeAppend x'4 y'4)
 
instance P'.Default DeniedToRoute where
  defaultValue = DeniedToRoute P'.defaultValue P'.defaultValue P'.defaultValue P'.defaultValue
 
instance P'.Wire DeniedToRoute where
  wireSize ft' self'@(DeniedToRoute x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeReq 1 9 x'1 + P'.wireSizeReq 1 5 x'2 + P'.wireSizeReq 1 9 x'3 + P'.wireSizeReq 1 5 x'4)
  wirePut ft' self'@(DeniedToRoute x'1 x'2 x'3 x'4)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutReq 10 9 x'1
             P'.wirePutReq 16 5 x'2
             P'.wirePutReq 26 9 x'3
             P'.wirePutReq 32 5 x'4
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{external_tcp_address = new'Field}) (P'.wireGet 9)
             16 -> Prelude'.fmap (\ !new'Field -> old'Self{external_tcp_port = new'Field}) (P'.wireGet 5)
             26 -> Prelude'.fmap (\ !new'Field -> old'Self{external_http_address = new'Field}) (P'.wireGet 9)
             32 -> Prelude'.fmap (\ !new'Field -> old'Self{external_http_port = new'Field}) (P'.wireGet 5)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self
 
instance P'.MessageAPI msg' (msg' -> DeniedToRoute) DeniedToRoute where
  getVal m' f' = f' m'
 
instance P'.GPB DeniedToRoute
 
instance P'.ReflectDescriptor DeniedToRoute where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList [10, 16, 26, 32]) (P'.fromDistinctAscList [10, 16, 26, 32])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".HES.Messages.DeniedToRoute\", haskellPrefix = [], parentModule = [MName \"HES\",MName \"Messages\"], baseName = MName \"DeniedToRoute\"}, descFilePath = [\"HES\",\"Messages\",\"DeniedToRoute.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.DeniedToRoute.external_tcp_address\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"DeniedToRoute\"], baseName' = FName \"external_tcp_address\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.DeniedToRoute.external_tcp_port\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"DeniedToRoute\"], baseName' = FName \"external_tcp_port\"}, fieldNumber = FieldId {getFieldId = 2}, wireTag = WireTag {getWireTag = 16}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.DeniedToRoute.external_http_address\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"DeniedToRoute\"], baseName' = FName \"external_http_address\"}, fieldNumber = FieldId {getFieldId = 3}, wireTag = WireTag {getWireTag = 26}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 9}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing},FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".HES.Messages.DeniedToRoute.external_http_port\", haskellPrefix' = [], parentModule' = [MName \"HES\",MName \"Messages\",MName \"DeniedToRoute\"], baseName' = FName \"external_http_port\"}, fieldNumber = FieldId {getFieldId = 4}, wireTag = WireTag {getWireTag = 32}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = True, canRepeat = False, mightPack = False, typeCode = FieldType {getFieldType = 5}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False}"