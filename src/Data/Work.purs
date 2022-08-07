module Data.Work where

type WorkId = Int

type Work =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , content :: String
  }
