module Components.Header where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, el, text)

header :: Component Contexts
header = el "div" do
  useClass $ pure "p-6"
  useClass $ pure "w-full"

  ch $ el "div" do
    useColor Highlight Text
    useColor Highlight Background

    useClass $ pure "text-4xl font-black"

    useClass $ pure "w-min"

    useClass $ pure "py-2 px-4"

    ch $ text $ pure "YukiNet"
