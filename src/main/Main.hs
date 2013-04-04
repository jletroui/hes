module Main(main) where

import HES.Client
import Control.Concurrent.Async (wait)

main :: IO ()
main = do
  putStrLn "Starting"
  client <- newClient 1113 "localhost"
  putStrLn "Created client"
  future <- createStream "someNewStream" client
  putStrLn "Called server"
  resp <- wait future  
  putStrLn "Received response"
  putStrLn (show resp)  