module Pages.PostInfo where

import Prelude

import Api.Posts (getPostInfo)
import Components.Markdown (markdownComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Contexts.Page (usePage)
import Data.Page (Page(..))
import Data.Post (PostId)
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, Signal, ch, chsSig, el, text, useSignal, writeAtom)
import Routing.Hash (getHash)

postInfoPageComponent :: Signal PostId -> Component Contexts
postInfoPageComponent postIdSig = el "div" do
  useClass $ pure "w-full"
  useClass $ pure "flex flex-col items-center justify-start p-4 gap-4"

  postMaybeSig /\ fetch <- useApi $ getPostInfo

  useSignal do
    postId <- postIdSig
    liftEffect $ launchAff_ $ fetch postId

  _ /\ pageAtom <- usePage

  chsSig do
    postMaybe <- postMaybeSig
    case postMaybe of
      Fetched post -> pure
        [ el "div" do
            usePopIn

            useClass $ pure "w-3/4 flex flex-col gap-4 items-start"

            ch $ el "div" do
              useClass $ pure "relative rounded overflow-hidden pl-3"
              useColor Highlight Background
              ch $ el "div" do
                useClass $ pure "text-3xl font-bold px-5 py-2 w-full"

                useColor Primary Background
                ch $ text $ pure $ post.title

            ch $ el "div" do
              useClass $ pure "w-full px-12 py-4 rounded shadow-md"

              useColor Primary Background
              ch $ markdownComponent $ pure $ post.content
        ]
      NotFetched -> pure []
      Failed -> do
        hash <- liftEffect $ getHash
        liftEffect $ writeAtom pageAtom $ PageNotFound hash
        pure []
