module Data.Post where

type PostId = Int

type PostInfo =
  { id :: PostId
  , title :: String
  , tags :: Array String
  , publishedAt :: String
  , content :: String
  }
