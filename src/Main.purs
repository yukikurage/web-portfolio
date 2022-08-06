module Main where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), getColor, provideColorMode, useColorMode) as CM
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Hooks.UseClass (useClass, useClasses)
import Jelly (Component, ch, el, launchApp, text)

main :: Effect Unit
main = do
  colorMode <- CM.provideColorMode
  launchApp root { colorMode }

root :: Component Contexts
root = el "div" do
  colorModeSig /\ _ <- CM.useColorMode

  useClass $ pure "h-screen w-screen"

  useClass $ pure "flex justify-center items-center"

  ch $ el "div" do
    useClasses do
      colorMode <- colorModeSig
      pure
        [ CM.getColor colorMode CM.Highlight CM.Text
        , CM.getColor colorMode CM.Highlight CM.Background
        ]

    useClass $ pure "font-Montserrat text-5xl"

    useClass $ pure "p-4"

    ch $ text $ pure "Hello, Jelly! Hello, tailwind!"
