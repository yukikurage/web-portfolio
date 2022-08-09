module Data.Work where

import Prelude

import Data.Tuple.Nested (type (/\))

type WorkId = Int

data WorkType = WorkTypeWeb | WorkTypeMusic | WorkTypeDrawing

derive instance Eq WorkType

type WorkInfo =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , thumbnailSize :: Int /\ Int
  , content :: String
  , workType :: WorkType
  }
