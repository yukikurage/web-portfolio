module Pages.WorksInfo where

import Prelude

import Api.Works (getWorksInfo)
import Components.Markdown (markdownComponent)
import Contexts (Contexts)
import Contexts.Page (usePage)
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Data.Work (WorkId)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Jelly (Component, Signal, ch, chsSig, el, useSignal, writeAtom)
import Routing.Hash (getHash)

workInfoPageComponent :: Signal WorkId -> Component Contexts
workInfoPageComponent workIdSig = el "div" do
  useClass $ pure "w-full"
  useClass $ pure "flex flex-col items-center justify-start"

  workMaybeSig /\ fetch <- useApi $ getWorksInfo

  useSignal do
    workId <- workIdSig
    liftEffect $ launchAff_ $ fetch workId

  _ /\ pageAtom <- usePage

  ch $ el "div" do
    useClass $ pure "w-2/3"
    chsSig do
      workMaybe <- workMaybeSig
      case workMaybe of
        Fetched work -> pure [ markdownComponent $ pure $ work.content ]
        NotFetched -> pure []
        Failed -> do
          hash <- liftEffect $ getHash
          liftEffect $ writeAtom pageAtom $ PageNotFound hash
          pure []
