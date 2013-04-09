module System.HES (
  newClient,
  createStream,

  -- * Convenience re-exports
  CreateStreamCompleted
  ) where

  import System.HES.Internal.Client
  import Data.HES.Messages.CreateStreamCompleted