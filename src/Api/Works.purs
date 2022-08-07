module Api.Works where

import Prelude

import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Data.Array (find)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Work (WorkId, WorkInfo, WorkItem)
import Effect.Aff (Aff)

type WorkInternal =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , contentURL :: String
  }

workInternals :: Array WorkInternal
workInternals =
  [ { contentURL: "works/jelly.md"
    , id: 1
    , title: "Jelly"
    , thumbnailURL: "null"
    }
  ]

getWorks :: Aff (Array WorkItem)
getWorks = pure $ map
  (\{ id, title, thumbnailURL } -> { id, title, thumbnailURL })
  workInternals

getWorksInfo :: WorkId -> Aff (Maybe WorkInfo)
getWorksInfo workId = do
  let
    workMaybe = find (\w -> w.id == workId) workInternals

  case workMaybe of
    Just { id, title, thumbnailURL, contentURL } -> do
      resEither <- get string contentURL
      case resEither of
        Left _ -> pure $ Nothing
        Right res -> pure $ Just { content: res.body, id, title, thumbnailURL }
    Nothing -> pure $ Nothing
