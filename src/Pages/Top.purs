module Pages.Top where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Array (range)
import Data.Functor (mapFlipped)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, ch, chs, el, text)

topPageComponent :: Component Contexts
topPageComponent = el "div" do
  useClass $ pure "fixed top-0 w-full h-full pointer-events-none"
  useClass $ pure "flex flex-col justify-center items-center gap-10"

  ch $ el "div" do
    useClass $ pure "w-96 h-24"
    useClass $ pure "flex justify-center items-center relative"

    ch $ el "div" do
      useColor Reverse Text
      useClass $ pure "text-6xl font-black font-Bungee z-20 relative"
      ch $ text $ pure "YUKINET"

    ch $ el "div" do
      useClass $ pure
        "absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-24 z-10 rounded-md overflow-hidden transition-shadow duration-500"
      useClass $ pure "flex flex-row"

      useDelayClass 1000 (pure "")
        (pure "shadow-lg")

      chs $ mapFlipped (range 0 7) \i -> el "div" do
        useClass $ pure "flex-1 overflow-hidden"

        ch $ el "div" do
          useClass $ pure
            "h-full transition-all"
          useDelayClass (50 + i * 50) (pure "w-[0%]") (pure "w-[101%]")

          useDelayClass (i * 50 + 100) (pure "duration-700 ease-in-out")
            (pure "")

          useColor Highlight Background

  ch $ el "div" do
    useClass $ pure "transition-all"
    useDelayClass 400 (pure "opacity-0") (pure "opacity-100")

    useClass $ pure "text-lg font-medium"
    ch $ text $ pure "ゆきくらげのウェブページ"
