module Data.HES.MessageCodes where

import Data.Word (Word8)

heartbeatRequestCommand :: Word8
heartbeatRequestCommand = 0x01
heartbeatResponseCommand :: Word8
heartbeatResponseCommand = 0x02

ping :: Word8
ping = 0x03
pong :: Word8
pong = 0x04

prepareAck :: Word8
prepareAck = 0x05
commitAck :: Word8
commitAck = 0x06

slaveAssignment :: Word8
slaveAssignment = 0x07
cloneAssignment :: Word8
cloneAssignment = 0x08

subscribeReplica :: Word8
subscribeReplica = 0x10
replicaLogPositionAck :: Word8
replicaLogPositionAck = 0x11
createChunk :: Word8
createChunk = 0x12
physicalChunkBulk :: Word8
physicalChunkBulk = 0x13
logicalChunkBulk :: Word8
logicalChunkBulk = 0x14

-- CLIENT COMMANDS
createStream :: Word8
createStream = 0x80
createStreamCompleted :: Word8
createStreamCompleted = 0x81

writeEvents :: Word8
writeEvents = 0x82
writeEventsCompleted :: Word8
writeEventsCompleted = 0x83

transactionStart :: Word8
transactionStart = 0x84
transactionStartCompleted :: Word8
transactionStartCompleted = 0x85
transactionWrite :: Word8
transactionWrite = 0x86
transactionWriteCompleted :: Word8
transactionWriteCompleted = 0x87
transactionCommit :: Word8
transactionCommit = 0x88
transactionCommitCompleted :: Word8
transactionCommitCompleted = 0x89

deleteStream :: Word8
deleteStream = 0x8A
deleteStreamCompleted :: Word8
deleteStreamCompleted = 0x8B

readEvent :: Word8
readEvent = 0xB0
readEventCompleted :: Word8
readEventCompleted = 0xB1
readStreamEventsForward :: Word8
readStreamEventsForward = 0xB2
readStreamEventsForwardCompleted :: Word8
readStreamEventsForwardCompleted = 0xB3
readStreamEventsBackward :: Word8
readStreamEventsBackward = 0xB4
readStreamEventsBackwardCompleted :: Word8
readStreamEventsBackwardCompleted = 0xB5
readAllEventsForward :: Word8
readAllEventsForward = 0xB6
readAllEventsForwardCompleted :: Word8
readAllEventsForwardCompleted = 0xB7
readAllEventsBackward :: Word8
readAllEventsBackward = 0xB8
readAllEventsBackwardCompleted :: Word8
readAllEventsBackwardCompleted = 0xB9

subscribeToStream :: Word8
subscribeToStream = 0xC0
subscriptionConfirmation :: Word8
subscriptionConfirmation = 0xC1
streamEventAppeared :: Word8
streamEventAppeared = 0xC2
unsubscribeFromStream :: Word8
unsubscribeFromStream = 0xC3
subscriptionDropped :: Word8
subscriptionDropped = 0xC4

scavengeDatabase :: Word8
scavengeDatabase = 0xD0

badRequest :: Word8
badRequest = 0xF0
deniedToRoute :: Word8
deniedToRoute = 0xF1

