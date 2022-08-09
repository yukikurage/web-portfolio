module Components.PageTitle where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, Signal, ch, el, text)

pageTitleComponent :: Signal String -> Component Contexts
pageTitleComponent titleSig = el "div" do
  useClass $ pure "relative w-full"

  useClass $ pure "flex justify-center"

  useClass $ pure "text-4xl font-bold"

  ch $ el "div" do
    useClass $ pure
      "absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 h-16 transition-all rounded shadow-md"

    useDelayClass 20 (pure "w-0") $ pure " w-80 rotate-3"

    useColor Highlight Background

  ch $ el "div" do
    useClass $ pure
      "absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-72 h-16 transition-all rounded shadow-md"

    useDelayClass 10 (pure "") $ pure "-rotate-6"

    useColor Reverse Background

  ch $ el "div" do
    useClass $ pure "relative transition-opacity"

    useDelayClass 100 (pure "opacity-0") $ pure "opacity-100"

    ch $ text $ titleSig

    useColor Reverse Text
