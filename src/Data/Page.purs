module Data.Page where

import Prelude

import Data.Either (either)
import Data.Foldable (oneOf)
import Data.Post (PostId)
import Data.Work (WorkId)
import Routing (match)
import Routing.Match (Match, end, int, lit)

data Page
  = PageAbout
  | PageWorks
  | PageWorkInfo WorkId
  | PagePosts
  | PagePostInfo PostId
  | PageNotFound String

derive instance Eq Page
derive instance Ord Page

pageToHash :: Page -> String
pageToHash = case _ of
  PageAbout -> "about"
  PageWorks -> "works"
  PageWorkInfo workId -> "works/" <> show workId
  PagePosts -> "posts"
  PagePostInfo postId -> "posts/" <> show postId
  PageNotFound path -> path

route :: Match Page
route =
  oneOf
    [ PageAbout <$ lit "about"
    , PageWorkInfo <$> (lit "works" *> int)
    , PageWorks <$ lit "works"
    , PagePostInfo <$> (lit "posts" *> int)
    , PagePosts <$ lit "posts"
    , pure $ PageAbout
    ]
    <* end

hashToPage :: String -> Page
hashToPage hash = either (const $ PageNotFound hash) identity $ match route hash
