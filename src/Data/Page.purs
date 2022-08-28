module Data.Page where

import Prelude

import Data.Either (either)
import Data.Foldable (oneOf)
import Data.Post (PostId)
import Data.Work (WorkId)
import Routing (match)
import Routing.Match (Match, end, lit, str)

data Page
  = PageTop
  | PageAbout
  | PageWorks
  | PageWorkInfo WorkId
  | PagePosts
  | PagePostInfo PostId
  | PageLinks
  | PageNotFound String

derive instance Eq Page
derive instance Ord Page

pageToHash :: Page -> String
pageToHash = case _ of
  PageTop -> ""
  PageAbout -> "about"
  PageWorks -> "works"
  PageWorkInfo workId -> "works/" <> workId
  PagePosts -> "posts"
  PagePostInfo postId -> "posts/" <> postId
  PageLinks -> "links"
  PageNotFound path -> path

route :: Match Page
route =
  oneOf
    [ PageAbout <$ lit "about"
    , PageWorkInfo <$> (lit "works" *> str)
    , PageWorks <$ lit "works"
    , PagePostInfo <$> (lit "posts" *> str)
    , PagePosts <$ lit "posts"
    , PageLinks <$ lit "links"
    , pure $ PageTop
    ]
    <* end

hashToPage :: String -> Page
hashToPage hash = either (const $ PageNotFound hash) identity $ match route hash

-- | navigation のところで使う
isParent :: Page -> Page -> Boolean
isParent PageWorks PageWorks = true
isParent PageWorks (PageWorkInfo _) = true
isParent PagePosts PagePosts = true
isParent PagePosts (PagePostInfo _) = true
isParent PageAbout PageAbout = true
isParent PageLinks PageLinks = true
isParent PageTop PageTop = true
isParent _ _ = false
