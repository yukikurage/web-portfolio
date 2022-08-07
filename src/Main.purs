module Main where

import Prelude

import Components.Markdown (markdownComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), provideColorMode) as CM
import Contexts.ColorMode (useColor)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Hooks.UseClass (useClass)
import Hooks.UseStaticFile (useStaticFile)
import Jelly (Component, ch, chsSig, el, launchApp, text)

main :: Effect Unit
main = do
  colorMode <- CM.provideColorMode
  launchApp root { colorMode }

root :: Component Contexts
root = el "div" do
  useClass $ pure "h-screen w-screen"

  useClass $ pure "p-20"

  useClass $ pure "flex flex-col items-start"

  useClass $ pure "gap-3"

  jellyMarkdownMaybeSig <- useStaticFile $ pure "./articles/jelly.md"

  ch $ el "div" do
    useColor CM.Highlight CM.Text
    useColor CM.Highlight CM.Background

    useClass $ pure "font-Montserrat text-5xl"

    useClass $ pure "py-4 px-6"

    ch $ text $ pure "Hello, Jelly & tailwind!"

  chsSig do
    jellyMarkdownMaybe <- jellyMarkdownMaybeSig
    pure case jellyMarkdownMaybe of
      Just jellyMarkdown -> [ markdownComponent $ pure $ jellyMarkdown ]
      Nothing -> []
