module Data.Work where

type WorkId = Int

type WorkItem =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  }

type WorkInfo =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , content :: String
  }
