module Pages.About where

import Prelude

import Api.About (getAbout)
import Components.ForeignLink (foreignLinkComponent)
import Components.Image (imageComponent)
import Components.Logo (logoComponent)
import Components.Markdown (markdownComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, ch, el, text, (:=))

aboutPageComponent :: Component Contexts
aboutPageComponent = el "div" do
  aboutStatusSig /\ fetchAbout <- useApi $ \_ -> getAbout
  liftEffect $ launchAff_ $ fetchAbout unit

  useClass $ pure "w-full"
  useClass $ pure "flex flex-col py-10 px-4 gap-12 items-center"

  -- ch $ pageTitleComponent $ pure "About"

  ch $ el "div" do
    usePopIn

    useColor Primary Background
    useClass $ pure
      "w-full md:w-3/4 flex flex-col rounded overflow-hidden shadow"

    ch $ imageComponent do
      "src" := pure "./img/1000/webp/Header.webp"
      "alt" := pure "Header"
      useClass $ pure "w-full h-40 md:h-60 xl:h-80 object-cover"

    ch $ el "div" do
      useClass $ pure "w-full"
      useClass $ pure "flex flex-col gap-2 p-8"

      ch $ el "div" do
        useClass $ pure "flex justify-start gap-2 items-baseline"

        ch $ el "div" do
          useClass $ pure "flex font-bold text-3xl"

          ch $ text $ pure "ゆきくらげ"

        ch $ el "div" do
          useClass $ pure "flex text-lg opacity-80"

          ch $ text $ pure "@yukikurage"

      ch $ el "div" do
        useClass $ pure "flex justify-start items-center gap-1 py-1 -ml-1"

        ch $ foreignLinkComponent
          do pure "https://twitter.com/yukikurage_2019"
          do
            pure $
              el "i" do
                useClass $ pure
                  "icon-twitter hover:opacity-70 transition-opacity text-3xl text-[#1DA1F2]"
        ch $ foreignLinkComponent
          do pure "https://github.com/yukikurage"
          do
            pure $
              el "i" do
                useClass $ pure
                  "icon-github-circled hover:opacity-70 transition-opacity text-3xl"
        ch $ foreignLinkComponent
          do pure "https://soundcloud.com/yukikurage"
          do
            pure $
              el "i" do
                useClass $ pure
                  "icon-soundcloud hover:opacity-70 transition-opacity text-3xl text-[#fe6d35]"

      ch $ markdownComponent do
        aboutStatus <- aboutStatusSig

        case aboutStatus of
          Fetched str -> pure str
          _ -> pure ""

    ch $ el "div" do
      useClass $ pure
        "w-full gap-2 p-8 flex flex-col items-center font-PassionOne text-3xl"
      ch $ el "div" do
        useClass $ pure "h-16"
        ch $ logoComponent
      ch $ el "div" do
        useClass $ pure "-skew-x-[9deg]"
        ch $ text $ pure "YUKIKURAGE"
