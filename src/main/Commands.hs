module Commands where

import Data.Word

heartbeatRequestCommand = 0x01 :: Word8
heartbeatResponseCommand = 0x02 :: Word8

ping = 0x03 :: Word8
pong = 0x04 :: Word8

prepareAck = 0x05 :: Word8
commitAck = 0x06 :: Word8

slaveAssignment = 0x07 :: Word8
cloneAssignment = 0x08 :: Word8

subscribeReplica = 0x10 :: Word8
replicaLogPositionAck = 0x11 :: Word8
createChunk = 0x12 :: Word8
physicalChunkBulk = 0x13 :: Word8
logicalChunkBulk = 0x14 :: Word8

-- CLIENT COMMANDS
createStream = 0x80 :: Word8
createStreamCompleted = 0x81 :: Word8

writeEvents = 0x82 :: Word8
writeEventsCompleted = 0x83 :: Word8

transactionStart = 0x84 :: Word8
transactionStartCompleted = 0x85 :: Word8
transactionWrite = 0x86 :: Word8
transactionWriteCompleted = 0x87 :: Word8
transactionCommit = 0x88 :: Word8
transactionCommitCompleted = 0x89 :: Word8

deleteStream = 0x8A :: Word8
deleteStreamCompleted = 0x8B :: Word8

readEvent = 0xB0 :: Word8
readEventCompleted = 0xB1 :: Word8
readStreamEventsForward = 0xB2 :: Word8
readStreamEventsForwardCompleted = 0xB3 :: Word8
readStreamEventsBackward = 0xB4 :: Word8
readStreamEventsBackwardCompleted = 0xB5 :: Word8
readAllEventsForward = 0xB6 :: Word8
readAllEventsForwardCompleted = 0xB7 :: Word8
readAllEventsBackward = 0xB8 :: Word8
readAllEventsBackwardCompleted = 0xB9 :: Word8

subscribeToStream = 0xC0 :: Word8
subscriptionConfirmation = 0xC1 :: Word8
streamEventAppeared = 0xC2 :: Word8
unsubscribeFromStream = 0xC3 :: Word8
subscriptionDropped = 0xC4 :: Word8

scavengeDatabase = 0xD0 :: Word8

badRequest = 0xF0 :: Word8
deniedToRoute = 0xF1 :: Word8
