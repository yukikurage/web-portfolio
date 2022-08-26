module Pages.PostInfo where

import Prelude

import Api.Posts (getPostInfo)
import Components.Markdown (markdownComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Contexts.Page (usePage)
import Data.Functor (mapFlipped)
import Data.Page (Page(..))
import Data.Post (PostId)
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, Signal, ch, chSig, chs, el, text, useSignal, writeAtom)
import Routing.Hash (getHash)
import Utils.GetDateText (getDateText)

postInfoPageComponent :: Signal PostId -> Component Contexts
postInfoPageComponent postIdSig = el "div" do
  useClass $ pure "w-full"
  useClass $ pure "flex flex-col items-center justify-start p-4 gap-4"

  postMaybeSig /\ fetch <- useApi $ getPostInfo

  useSignal do
    postId <- postIdSig
    liftEffect $ launchAff_ $ fetch postId

  _ /\ pageAtom <- usePage

  chSig do
    postMaybe <- postMaybeSig
    case postMaybe of
      Fetched post -> pure $ el "div" do
        usePopIn

        useClass $ pure "w-full md:w-3/4 flex flex-col gap-4 items-start"

        ch $ el "div" do
          useClass $ pure "relative rounded overflow-hidden pl-3"
          useColor Highlight Background
          ch $ el "div" do
            useClass $ pure "px-4 py-2 w-full flex flex-col gap-2 items-start"

            useColor Primary Background

            ch $ el "div" do
              useClass $ pure "text-sm"

              dateText <- liftEffect $ getDateText post.publishedAt

              ch $ text $ pure $ dateText

            ch $ el "div" do
              useClass $ pure "text-3xl font-bold pl-1"
              ch $ text $ pure $ post.title

        ch $ el "div" do
          useColor Primary Background
          useClass $ pure "relative rounded overflow-hidden px-4 py-2"
          ch $ el "div" do
            useClass $ pure "flex flex-row gap-2 opacity-90 flex-wrap pl-1"
            chs $ mapFlipped post.tags \tag -> el "p" do
              useClass $ pure "text-sm"

              ch $ text $ pure $ "#" <> tag

        ch $ el "div" do
          useClass $ pure "w-full px-12 py-4 rounded shadow-md"

          useColor Primary Background
          ch $ markdownComponent $ pure $ post.content
      NotFetched -> pure $ el "div" $ pure unit
      Failed -> do
        hash <- liftEffect $ getHash
        liftEffect $ writeAtom pageAtom $ PageNotFound hash
        pure $ el "div" $ pure unit
