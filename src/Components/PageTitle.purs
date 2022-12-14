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
      "absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 h-14 transition-all rounded shadow"

    useDelayClass 10 (pure "w-0") $ pure " w-72 rotate-3"

    useColor Highlight Background

  ch $ el "div" do
    useClass $ pure
      "absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-64 h-16 transition-all rounded shadow"

    useDelayClass 10 (pure "") $ pure "-rotate-6"

    useColor Primary Background

  ch $ el "div" do
    useClass $ pure "relative transition-opacity"

    useDelayClass 10 (pure "opacity-0") $ pure "opacity-100"

    ch $ text $ titleSig

    useColor Primary Text
