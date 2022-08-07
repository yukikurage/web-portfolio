module Data.Page where

import Prelude

import Data.Either (either)
import Data.Foldable (oneOf)
import Data.Work (WorkId)
import Routing (match)
import Routing.Match (Match, end, int, lit)

data Page = PageAbout | PageWorks | PageWorksInfo WorkId | PageNotFound String

derive instance Eq Page
derive instance Ord Page

pageToHash :: Page -> String
pageToHash = case _ of
  PageAbout -> "about"
  PageWorks -> "works"
  PageWorksInfo workId -> "works/" <> show workId
  PageNotFound path -> path

route :: Match Page
route =
  oneOf
    [ PageAbout <$ lit "about"
    , PageWorksInfo <$> (lit "works" *> int)
    , PageWorks <$ lit "works"
    , pure $ PageAbout
    ]
    <* end

hashToPage :: String -> Page
hashToPage hash = either (const $ PageNotFound hash) identity $ match route hash

defaultPage :: Page
defaultPage = PageAbout
