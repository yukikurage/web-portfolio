module Api.Posts where

import Prelude

import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Data.Array (find)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Post (PostId, PostInfo, PostItem)
import Effect.Aff (Aff)

type PostInternal =
  { id :: PostId
  , title :: String
  , contentURL :: String
  }

workInternals :: Array PostInternal
workInternals =
  [ { contentURL: "posts/test.md"
    , id: 1
    , title: "Test"
    }
  ]

getPosts :: Aff (Array PostItem)
getPosts = pure $ map
  (\{ id, title } -> { id, title })
  workInternals

getPostsInfo :: PostId -> Aff (Maybe PostInfo)
getPostsInfo workId = do
  let
    workMaybe = find (\w -> w.id == workId) workInternals

  case workMaybe of
    Just { id, title, contentURL } -> do
      resEither <- get string contentURL
      case resEither of
        Left _ -> pure $ Nothing
        Right res -> pure $ Just { content: res.body, id, title }
    Nothing -> pure $ Nothing
