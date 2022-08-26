module Api.About where

import Prelude

import Affjax.ResponseFormat (string)
import Affjax.Web (get)
import Data.Either (hush)
import Data.Maybe (Maybe)
import Effect.Aff (Aff)

getAbout :: Aff (Maybe String)
getAbout = map (_.body) <<< hush <$> get string "./about.md"
