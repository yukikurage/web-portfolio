module Data.Work where

type WorkId = String

type WorkInfo =
  { id :: WorkId
  , title :: String
  , thumbnail :: String
  , content :: String
  , tags :: Array String
  }
