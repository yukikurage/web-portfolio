module Utils.GetContentFulImageLink where

import Prelude

getContentfulImageLink :: String -> String
getContentfulImageLink url = "https:" <> url <> "?fm=webp&q=50"
