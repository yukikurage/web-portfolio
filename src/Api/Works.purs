module Api.Works where

import Prelude

import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Work (WorkInfo)
import Effect.Aff (Aff)
import Simple.JSON (readJSON_)

getWorks :: Aff (Maybe (Array WorkInfo))
getWorks = do
  resEither <- get string "./works.json"
  pure $ case resEither of
    Left _ -> Nothing
    Right res -> readJSON_ res.body
