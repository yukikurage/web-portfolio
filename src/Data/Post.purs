module Data.Post where

type PostId = Int

type PostItem =
  { id :: PostId
  , title :: String
  }

type PostInfo =
  { id :: PostId
  , title :: String
  , content :: String
  }
