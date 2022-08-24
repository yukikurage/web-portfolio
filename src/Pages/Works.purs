module Pages.Works where

import Prelude

import Api.Works (getWorks)
import Components.ForeignLink (foreignLinkComponent)
import Components.Image (imageComponent)
import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Functor (mapFlipped)
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, ch, chSig, chs, el, text, (:=))

worksPageComponent :: Component Contexts
worksPageComponent = el "div" do
  worksStatusSig /\ fetchWorks <- useApi $ \_ -> getWorks
  liftEffect $ launchAff_ $ fetchWorks unit

  useClass $ pure "w-full"
  useClass $ pure "flex flex-col p-10 gap-28 items-center"

  ch $ pageTitleComponent $ pure "Works"
  chSig do
    worksStatus <- worksStatusSig
    pure case worksStatus of
      Fetched works -> el "div" do
        useClass $ pure "w-full md:w-3/4"
        useClass $ pure
          "grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-x-8 gap-y-12"
        usePopIn
        chs $ mapFlipped works \work -> foreignLinkComponent (pure work.link)
          $ pure
          $ el "div" do
              useClass $ pure
                "relative w-full h-52 overflow-hidden rounded shadow-md group hover:opacity-80 transition-opacity"

              ch $ imageComponent do
                "src" := pure work.thumbnailURL
                "alt" := pure work.title
                useClass $ pure
                  "absolute top-0 left-0 w-full h-full object-cover transition-all group-hover:blur-sm group-hover:scale-105"

              ch $ el "div" do
                useClass $ pure
                  "absolute left-0 top-0 w-full h-full opacity-20 transition-opacity"

                useColor Reverse Background

              ch $ el "div" do
                useClass $ pure
                  "absolute h-[8rem] w-[120%] -rotate-6 -left-[10%] -top-[2rem] pointer-events-none transition-all overflow-hidden"

                useColor Primary Background

              ch $ el "div" do
                useClass $ pure
                  "absolute top-0 left-0 pointer-events-none w-full p-4 flex flex-col gap-2"
                useColor Primary Text
                ch $ el "h1" do
                  useClass $ pure "text-2xl font-bold"
                  ch $ text $ pure work.title
                ch $ el "div" do
                  useClass $ pure "flex flex-row gap-2 opacity-90 flex-wrap"
                  chs $ mapFlipped work.tags \tag -> el "p" do
                    useClass $ pure "text-sm"

                    ch $ text $ pure $ "#" <> tag

      _ -> el "div" $ pure unit
