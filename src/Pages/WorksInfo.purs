module Pages.Works where

import Prelude

import Components.Markdown (markdownComponent)
import Contents.Works (getWorksInfo)
import Contexts (Contexts)
import Contexts.Page (usePage)
import Data.Pages (Page(..))
import Data.Tuple.Nested ((/\))
import Data.Work (WorkId)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Jelly (Component, Signal, chsSig, el, useSignal, writeAtom)
import Routing.Hash (getHash)

worksInfoPageComponent :: Signal WorkId -> Component Contexts
worksInfoPageComponent workIdSig = el "div" do
  workMaybeSig /\ fetch <- useApi $ getWorksInfo

  useSignal do
    workId <- workIdSig
    liftEffect $ launchAff_ $ fetch workId

  _ /\ pageAtom <- usePage

  chsSig do
    workMaybe <- workMaybeSig
    case workMaybe of
      Fetched work -> pure [ markdownComponent $ pure $ work.content ]
      NotFetched -> pure []
      Failed -> do
        hash <- liftEffect $ getHash
        liftEffect $ writeAtom pageAtom $ PageNotFound hash
        pure []
