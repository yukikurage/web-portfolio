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
        useClass $ pure "w-3/4"
        useClass $ pure "flex flex-row gap-10"
        usePopIn
        chs $ mapFlipped works \work -> foreignLinkComponent (pure work.link)
          $ pure
          $ el "div" do
              useColor Primary Background

              useClass $ pure
                "relative w-60 h-72 overflow-hidden rounded shadow-md group bg-opacity-70"

              ch $ imageComponent do
                "src" := pure work.thumbnailURL
                "alt" := pure work.title
                useClass $ pure
                  "absolute left-0 bottom-0 w-full h-3/4 object-cover transition-all group-hover:blur-sm group-hover:scale-105 duration-500"

              ch $ el "div" do
                useClass $ pure
                  "absolute left-0 top-0 w-full h-full opacity-0 group-hover:opacity-40 transition-opacity"

                useColor Primary Background

              ch $ el "p" do
                useClass $ pure
                  "absolute left-0 top-[170px] opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none p-3"
                useClass $ pure "text-lg"
                ch $ text $ pure work.description

              ch $ el "div" do
                useClass $ pure
                  "absolute h-[210px] w-[150%] -rotate-6 -left-1/4 -top-1/4 pointer-events-none shadow-md transition-all"

                useColor Highlight Background

              ch $ el "div" do
                useClass $ pure
                  "absolute h-[200px] w-[150%] -rotate-6 -left-1/4 -top-1/4 pointer-events-none shadow-md transition-all"

                useColor Reverse Background

              ch $ el "div" do
                useClass $ pure
                  "absolute top-0 left-0 pointer-events-none w-full p-4 flex flex-col gap-2"
                useColor Reverse Text
                ch $ el "h1" do
                  useClass $ pure "text-2xl font-bold"
                  ch $ text $ pure work.title
                ch $ el "div" do
                  useClass $ pure "flex flex-row gap-2 opacity-90 flex-wrap"
                  chs $ mapFlipped work.tags \tag -> el "p" do
                    useClass $ pure "text-sm"

                    ch $ text $ pure $ "#" <> tag

      _ -> el "div" $ pure unit
