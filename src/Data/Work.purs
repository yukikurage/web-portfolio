module Data.Work where

import Prelude

import Simple.JSON (class ReadForeign, readImpl)

type WorkId = Int

data WorkType = WorkTypeWeb | WorkTypeMusic | WorkTypeDrawing

derive instance Eq WorkType
instance ReadForeign WorkType where
  readImpl x = do
    str <- readImpl x
    case str of
      "music" -> pure WorkTypeMusic
      "drawing" -> pure WorkTypeDrawing
      _ -> pure WorkTypeWeb

type WorkInfo =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , description :: String
  , workType :: WorkType
  , link :: String
  }
