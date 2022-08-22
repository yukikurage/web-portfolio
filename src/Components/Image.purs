module Components.Image where

import Prelude

import Contexts (Contexts)
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Jelly (Component, Hook, ch, el, on, signal, writeAtom, (:=))

imageComponent :: Hook Contexts Unit -> Component Contexts
imageComponent hooks = el "div" do
  isLoadedSig /\ isLoadedAtom <- signal false

  useClass do
    isLoaded <- isLoadedSig
    pure $ if isLoaded then "opacity-100" else "opacity-0"

  useClass $ pure "transition-opacity duration-500 w-full h-full"

  ch $ el "img" do
    "loading" := pure "lazy"

    on "load" \_ -> writeAtom isLoadedAtom true
    hooks
