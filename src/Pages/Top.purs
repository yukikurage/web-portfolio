module Pages.Top where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Array (replicate)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, ch, chs, el, text)

topPageComponent :: Component Contexts
topPageComponent = el "div" do
  useClass $ pure "relative w-full h-full"
  useClass $ pure "flex justify-center items-center"

  ch $ el "div" do
    useColor Reverse Text

    useClass $ pure "relative w-96 h-24 z-20"
    useClass $ pure "flex justify-center items-center"
    useClass $ pure "text-6xl font-black font-Bungee"

    ch $ text $ pure "YUKINET"

  ch $ el "div" do
    useClass $ pure
      "absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-24 z-10"
    useClass $ pure "flex flex-row"

    chs $ replicate 7 $ el "div" do
      useClass $ pure "flex-1 overflow-hidden"

      ch $ el "div" do
        useClass $ pure
          "h-full transition-all "
        useDelayClass 50 (pure "w-[0%]") (pure "w-[110%]")

        useDelayClass 1100 (pure "duration-1000") (pure "")

        useColor Highlight Background
