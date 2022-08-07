module Main where

import Prelude

import Components.Header (header)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..)) as CM
import Contexts.ColorMode (provideColorMode, useColor)
import Contexts.Page (providePage, usePage)
import Data.Pages (Page(..))
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, chSig, el, launchApp)
import Pages.About (aboutPageComponent)
import Pages.NotFound (notFoundPageComponent)
import Pages.Work (worksPageComponent)
import Pages.Works (worksInfoPageComponent)

main :: Effect Unit
main = do
  colorMode <- provideColorMode
  page <- providePage
  launchApp root { colorMode, page }

root :: Component Contexts
root = el "div" do
  useColor CM.Primary CM.Text
  useColor CM.Primary CM.Background

  useClass $ pure "font-default"

  useClass $ pure "h-screen w-screen"

  useClass $ pure "flex flex-col items-start"

  useClass $ pure "gap-3"

  pageSig /\ pageAtom <- usePage

  ch $ header

  chSig do
    page <- pageSig

    pure $ case page of
      PageAbout -> aboutPageComponent
      PageWorks -> worksPageComponent
      PageWorksInfo workId -> worksInfoPageComponent $ pure workId
      PageNotFound path -> notFoundPageComponent $ pure path
