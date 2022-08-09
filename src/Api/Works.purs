module Api.Works where

import Prelude

import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Data.Array (find)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Traversable (for, sequence)
import Data.Tuple.Nested (type (/\), (/\))
import Data.Work (WorkId, WorkInfo, WorkType(..))
import Effect.Aff (Aff)

type WorkInternal =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , contentURL :: String
  , thumbnailSize :: Int /\ Int
  , workType :: WorkType
  }

workInternals :: Array WorkInternal
workInternals =
  [ { contentURL: "works/jelly.md"
    , id: 1
    , title: "Jelly"
    , thumbnailURL: "null"
    , thumbnailSize: 0 /\ 0
    , workType: WorkTypeWeb
    }
  ]

getWorksInfo :: WorkId -> Aff (Maybe WorkInfo)
getWorksInfo workId = do
  let
    workMaybe = find (\w -> w.id == workId) workInternals

  case workMaybe of
    Just { id, title, thumbnailURL, contentURL, thumbnailSize, workType } -> do
      resEither <- get string contentURL
      case resEither of
        Left _ -> pure $ Nothing
        Right res -> pure $ Just
          { content: res.body
          , id
          , title
          , thumbnailURL
          , thumbnailSize
          , workType
          }
    Nothing -> pure $ Nothing

getWorks :: Aff (Maybe (Array WorkInfo))
getWorks = sequence <$> for workInternals \{ id } -> getWorksInfo id
