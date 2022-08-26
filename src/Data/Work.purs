module Data.Work where

type WorkId = Int

type WorkInfo =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , content :: String
  , tags :: Array String
  }
