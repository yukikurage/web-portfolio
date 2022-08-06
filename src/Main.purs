module Main where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), provideColorMode) as CM
import Contexts.ColorMode (useColor)
import Effect (Effect)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, el, launchApp, text)

main :: Effect Unit
main = do
  colorMode <- CM.provideColorMode
  launchApp root { colorMode }

root :: Component Contexts
root = el "div" do
  useClass $ pure "h-screen w-screen"

  useClass $ pure "flex justify-center items-center"

  ch $ el "div" do
    useColor CM.Highlight CM.Text
    useColor CM.Highlight CM.Background

    useClass $ pure "font-Montserrat text-5xl"

    useClass $ pure "p-4"

    ch $ text $ pure "Hello, Jelly & tailwind!"
