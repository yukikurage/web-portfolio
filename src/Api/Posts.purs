module Api.Posts where

import Prelude

import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Data.Array (find)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Post (PostId, PostInfo)
import Data.Traversable (sequence, traverse)
import Effect.Aff (Aff)
import Simple.JSON (readJSON_)

type PostInternal =
  { id :: PostId
  , title :: String
  , tags :: Array String
  , publishedAt :: String
  , contentURL :: String
  }

fromPostInternal :: PostInternal -> Aff (Maybe PostInfo)
fromPostInternal post = do
  resEither <- get string post.contentURL
  pure $ case resEither of
    Left _ -> Nothing
    Right res -> Just
      { id: post.id
      , title: post.title
      , tags: post.tags
      , publishedAt: post.publishedAt
      , content: res.body
      }

getPosts :: Aff (Maybe (Array PostInfo))
getPosts = do
  resEither <- get string "./posts.json"
  case resEither of
    Left _ -> pure Nothing
    Right res -> do
      case readJSON_ res.body of
        Nothing -> pure $ Nothing
        Just postInternals -> do
          posts <- traverse fromPostInternal postInternals
          pure $ sequence posts

getPostInfo :: PostId -> Aff (Maybe PostInfo)
getPostInfo id = do
  postsMaybe <- getPosts
  pure $ case postsMaybe of
    Nothing -> Nothing
    Just posts -> find (\post -> post.id == id) posts
