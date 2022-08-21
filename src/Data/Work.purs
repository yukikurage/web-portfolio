module Data.Work where

type WorkId = Int

type WorkInfo =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , description :: String
  , tags :: Array String
  , link :: String
  }
