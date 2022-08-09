module Pages.Works where

import Prelude

import Api.Works (getWorks)
import Components.ForeignLink (foreignLinkComponent)
import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
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
  useClass $ pure "flex flex-col p-12 gap-16 items-center"

  ch $ pageTitleComponent $ pure "Works"
  chSig do
    worksStatus <- worksStatusSig
    pure case worksStatus of
      Fetched works -> el "div" do
        useClass $ pure "w-3/4"
        useClass $ pure "flex flex-col gap-10"
        usePopIn
        chs $ mapFlipped works \work -> el "div" do
          useClass $ pure "flex flex-row gap-16"
          ch $ foreignLinkComponent (pure work.link) $ pure $ el "img" do
            "src" := pure work.thumbnailURL
            "alt" := pure work.title
            useClass $ pure
              "w-64 h-36 object-cover rounded shadow-md hover:opacity-80 transition-opacity"
          ch $ el "div" do
            ch $ foreignLinkComponent (pure work.link) $ pure $ el "h1" do
              useClass $ pure "text-2xl my-3 font-bold"
              ch $ text $ pure work.title
              useClass $ pure
                "hover:opacity-80 transition-opacity"
            ch $ el "p" do
              useClass $ pure "text-lg ml-4"
              ch $ text $ pure work.description

      _ -> el "div" $ pure unit
