module Contentful where

import Prelude

import Control.Promise (Promise, toAffE)
import Data.Array (catMaybes)
import Data.Maybe (Maybe)
import Data.Post (PostId, PostInfo)
import Data.Work (WorkInfo)
import Effect (Effect)
import Effect.Aff (Aff)
import Simple.JSON (readJSON_)

foreign import data ContentfulClientApi :: Type

foreign import getPostsImpl :: Effect (Promise (Array String))
foreign import getWorksImpl :: Effect (Promise (Array String))

foreign import getPostInfoImpl :: String -> Effect (Promise String)

getPosts :: Aff (Array PostInfo)
getPosts = do
  postStrings <- toAffE getPostsImpl
  pure $ catMaybes $ map readJSON_ postStrings

getWorks :: Aff (Array WorkInfo)
getWorks = do
  workStrings <- toAffE getWorksImpl
  pure $ catMaybes $ map readJSON_ workStrings

getPostInfo :: PostId -> Aff (Maybe PostInfo)
getPostInfo postId = readJSON_ <$> (toAffE $ getPostInfoImpl $ postId)

imageRoot :: String
imageRoot =
  "https://images.ctfassets.net/iitjhomwjrtq/655TsBOYc5nVieNrY14lge/f14b7cd06aa29d2efc2bbac3268c1717/"
