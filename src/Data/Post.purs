module Data.Post where

type PostId = String

type PostInfo =
  { id :: PostId
  , title :: String
  , tags :: Array String
  , createdAt :: String
  , content :: String
  }
