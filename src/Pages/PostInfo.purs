module Pages.PostInfo where

import Prelude

import Api.Posts (getPostsInfo)
import Components.Markdown (markdownComponent)
import Contexts (Contexts)
import Contexts.Page (usePage)
import Data.Page (Page(..))
import Data.Post (PostId)
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Jelly (Component, Signal, chsSig, el, useSignal, writeAtom)
import Routing.Hash (getHash)

postInfoPageComponent :: Signal PostId -> Component Contexts
postInfoPageComponent postIdSig = el "div" do
  postMaybeSig /\ fetch <- useApi $ getPostsInfo

  useSignal do
    postId <- postIdSig
    liftEffect $ launchAff_ $ fetch postId

  _ /\ pageAtom <- usePage

  chsSig do
    postMaybe <- postMaybeSig
    case postMaybe of
      Fetched post -> pure [ markdownComponent $ pure $ post.content ]
      NotFetched -> pure []
      Failed -> do
        hash <- liftEffect $ getHash
        liftEffect $ writeAtom pageAtom $ PageNotFound hash
        pure []
