module Api.Works where

import Prelude

import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Data.Array (find)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Traversable (sequence, traverse)
import Data.WebWork (WorkId)
import Data.Work (WorkInfo)
import Effect.Aff (Aff)
import Simple.JSON (readJSON_)

type WorkInternal =
  { id :: WorkId
  , title :: String
  , thumbnailURL :: String
  , contentURL :: String
  , tags :: Array String
  }

fromWorkInternal :: WorkInternal -> Aff (Maybe WorkInfo)
fromWorkInternal work = do
  resEither <- get string work.contentURL
  case resEither of
    Left _ -> pure $ Nothing
    Right res -> do
      pure $ Just
        { id: work.id
        , title: work.title
        , tags: work.tags
        , thumbnailURL: work.thumbnailURL
        , content: res.body
        }

getWorks :: Aff (Maybe (Array WorkInfo))
getWorks = do
  resEither <- get string "./works.json"
  case resEither of
    Left _ -> pure Nothing
    Right res -> do
      case readJSON_ res.body of
        Nothing -> pure $ Nothing
        Just workInternals -> do
          works <- traverse fromWorkInternal workInternals
          pure $ sequence works

getWorkInfo :: WorkId -> Aff (Maybe WorkInfo)
getWorkInfo id = do
  worksMaybe <- getWorks
  pure $ case worksMaybe of
    Nothing -> Nothing
    Just works -> find (\work -> work.id == id) works
