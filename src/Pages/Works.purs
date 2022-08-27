module Pages.Works where

import Prelude

import Api.Works (getWorks)
import Components.Image (imageComponent)
import Components.Markdown (markdownComponent)
import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Functor (mapFlipped)
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Hooks.UseDialog (useDialog)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, ch, chSig, chs, el, on, signal, text, writeAtom, (:=))

worksPageComponent :: Component Contexts
worksPageComponent = el "div" do
  worksStatusSig /\ fetchWorks <- useApi $ \_ -> getWorks
  liftEffect $ launchAff_ $ fetchWorks unit

  useClass $ pure "w-full"
  useClass $ pure "flex flex-col py-10 px-4 gap-12 items-center"

  ch $ pageTitleComponent $ pure "Works"
  chSig do
    worksStatus <- worksStatusSig
    pure case worksStatus of
      Fetched works -> el "div" do
        useClass $ pure "w-full md:w-3/4"

        ch $ el "div" do
          useClass $ pure
            "grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-x-4 gap-y-4"
          chs $ mapFlipped works \work -> el "div" do
            isOpenDialogSig /\ isOpenDialogAtom <- signal false

            on "click" \_ -> do
              writeAtom isOpenDialogAtom $ true

            useClass $ pure
              "relative w-full h-52 overflow-hidden rounded shadow-md group hover:opacity-80 transition-opacity cursor-pointer"

            ch $ imageComponent do
              "src" := pure work.thumbnailURL
              "alt" := pure work.title
              useClass $ pure
                "absolute top-0 left-0 w-full h-full object-cover transition-all group-hover:blur-sm group-hover:scale-105"

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

            chSig do
              isOpenDialog <- isOpenDialogSig
              pure $
                if isOpenDialog then
                  el "div" do
                    useDialog (writeAtom isOpenDialogAtom false) $ pure
                      $ el "div" do
                          useClass $ pure "rounded-md"
                          useClass $ pure
                            "flex flex-col md:flex-row h-[35rem] overflow-hidden shadow-md"
                          useColor Primary Background

                          ch $ el "div" do
                            useClass $ pure
                              "w-full h-24 md:w-1/3 md:h-full"

                            ch $ imageComponent do
                              "src" := pure work.thumbnailURL
                              "alt" := pure work.title
                              useClass $ pure
                                "w-full h-full object-cover"

                          ch $ el "div" do
                            useClass $ pure
                              "flex flex-col gap-2 p-6 flex-1 h-full overflow-y-auto"

                            ch $ el "div" do
                              useClass $ pure "font-bold text-3xl"

                              ch $ text $ pure work.title

                            ch $ el "div" do
                              useClass $ pure
                                "flex flex-row gap-2 opacity-90 flex-wrap"
                              chs $ mapFlipped work.tags \tag -> el "p" do
                                useClass $ pure "text-sm"

                                ch $ text $ pure $ "#" <> tag

                            ch $ markdownComponent $ pure $ work.content
                else el "div" $ pure unit

      _ -> el "div" $ pure unit
