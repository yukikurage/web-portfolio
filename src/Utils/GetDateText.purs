module Utils.GetDateText where

import Prelude

import Data.Int (floor)
import Data.JSDate as JSDate
import Effect (Effect)

getDateText :: JSDate.JSDate -> Effect String
getDateText jsDate = do
  year <- floor <$> JSDate.getFullYear jsDate
  month <- floor <$> JSDate.getMonth jsDate
  date <- floor <$> JSDate.getDate jsDate
  pure $ show year <> "/" <> show (month + 1) <> "/" <> show date
