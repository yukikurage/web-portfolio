module Data.Post where

import Data.JSDate (JSDate)

type PostId = Int

type PostInfo =
  { id :: PostId
  , title :: String
  , tags :: Array String
  , publishedAt :: JSDate
  , content :: String
  }
