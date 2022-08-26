module Pages.About where

import Prelude

import Api.About (getAbout)
import Components.ForeignLink (foreignLinkComponent)
import Components.Image (imageComponent)
import Components.Markdown (markdownComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, el, text, (:=))

aboutPageComponent :: Component Contexts
aboutPageComponent = el "div" do
  aboutStatusSig /\ fetchAbout <- useApi $ \_ -> getAbout
  liftEffect $ launchAff_ $ fetchAbout unit

  useClass $ pure "w-full"
  useClass $ pure "flex flex-col py-10 px-4 gap-12 items-center"

  -- ch $ pageTitleComponent $ pure "About"

  ch $ el "div" do
    useColor Primary Background
    useClass $ pure
      "w-full md:w-3/4 flex flex-col rounded overflow-hidden shadow-md"

    ch $ imageComponent do
      "src" := pure "./img/Header.png"
      useClass $ pure "w-full h-40 md:h-60 xl:h-80 object-cover"

    ch $ el "div" do
      useClass $ pure "w-full"
      useClass $ pure "flex flex-col gap-2 p-6"

      ch $ el "div" do
        useClass $ pure "flex justify-start gap-4 items-baseline"

        ch $ el "div" do
          useClass $ pure "flex font-bold text-3xl"

          ch $ text $ pure "ゆきくらげ"

        ch $ el "div" do
          useClass $ pure "flex text-lg opacity-80"

          ch $ text $ pure "@yukikurage"

      ch $ el "div" do
        useClass $ pure "flex justify-start gap-6 py-2"

        ch $ foreignLinkComponent
          do pure "https://twitter.com/yukikurage_2019"
          do
            pure $
              el "i" do
                useClass $ pure
                  "fa-brands fa-twitter fa-2x hover:opacity-80 transition-opacity"
        ch $ foreignLinkComponent
          do pure "https://github.com/yukikurage"
          do
            pure $
              el "i" do
                useClass $ pure
                  "fa-brands fa-github fa-2x hover:opacity-80 transition-opacity"
        ch $ foreignLinkComponent
          do pure "https://soundcloud.com/yukikurage"
          do
            pure $
              el "i" do
                useClass $ pure
                  "fa-brands fa-soundcloud fa-2x hover:opacity-80 transition-opacity"

      ch $ markdownComponent do
        aboutStatus <- aboutStatusSig

        case aboutStatus of
          Fetched str -> pure str
          _ -> pure ""
