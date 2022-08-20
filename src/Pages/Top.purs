module Pages.Top where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, ch, el, text)

topPageComponent :: Component Contexts
topPageComponent = el "div" do
  useClass $ pure "fixed top-0 w-full h-full pointer-events-none"
  useClass $ pure "flex flex-col justify-center items-center gap-5"

  ch $ el "div" do
    useClass $ pure "h-24"
    useDelayClass 200 (pure "w-0") (pure "w-96")
    useClass $ pure
      "flex flex-col justify-center items-center relative overflow-hidden shadow-lg rounded-md  transition-all"
    useColor Highlight Background
    useDelayClass 400 (pure "duration-700") (pure "")

    ch $ el "div" do
      useColor Reverse Text
      useClass $ pure "text-6xl font-black font-Bungee z-20 relative"
      ch $ text $ pure "Yukinet"

  ch $ el "div" do
    useClass $ pure "transition-all"

    useDelayClass 400 (pure "opacity-0") (pure "opacity-100")

    useClass $ pure "text-lg font-medium"
    ch $ text $ pure "ゆきくらげのウェブページ"
