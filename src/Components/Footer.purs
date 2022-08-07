module Components.Footer where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Hooks.UseClass (useClass)
import Jelly (Component, Signal, ch, chSig, el, text, (:=))

footerComponent :: Component Contexts
footerComponent = el "div" do
  useClass $ pure "w-full h-32 py-3 px-6"

  useColor Reverse Text
  useColor Reverse Background

  useClass $ pure "text-opacity-80"
  useClass $ pure "flex flex-col gap-3"

  ch $ el "p" $ ch $ text $ pure "©2022 YUKINET"
  ch $ el "p" do
    useClass $ pure "flex flex-row gap-2 items-baseline"
    ch $ linkText
      do
        pure "https://github.com/yukikurage/web-portfolio"
      do
        pure $ el "i" do
          useClass $ pure "fa-brands fa-brands fa-github fa-2x"
    ch $ text $ pure "made by "
    ch $ linkText
      do
        pure "https://github.com/yukikurage/purescript-jelly"
      do
        pure $ text $ pure "Jelly"

linkText :: Signal String -> Signal (Component Contexts) -> Component Contexts
linkText linkSig componentSig = el "a" do
  useClass $ pure "text-opacity-80 hover:text-opacity-100 font-bold"
  useColor Reverse Text

  "href" := linkSig
  "target" := pure "_blank"
  "rel" := pure "noopener noreferrer"

  chSig componentSig
