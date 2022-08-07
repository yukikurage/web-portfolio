module Main where

import Prelude

import Components.Footer (footerComponent)
import Components.Header (headerComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..)) as CM
import Contexts.ColorMode (provideColorMode, useColor)
import Contexts.Page (providePage, usePage)
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Hooks.UseAdjustWindowHeight (useAdjustWindowHeight)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, chSig, el, launchApp)
import Pages.About (aboutPageComponent)
import Pages.NotFound (notFoundPageComponent)
import Pages.PostInfo (postInfoPageComponent)
import Pages.Posts (postsPageComponent)
import Pages.Top (topPageComponent)
import Pages.Works (worksPageComponent)
import Pages.WorksInfo (workInfoPageComponent)

main :: Effect Unit
main = do
  colorMode <- provideColorMode
  page <- providePage
  launchApp root { colorMode, page }

root :: Component Contexts
root = el "div" do
  useAdjustWindowHeight

  useColor CM.Primary CM.Text
  useColor CM.Primary CM.Background

  useClass $ pure "font-default"
  useClass $ pure "w-screen"
  useClass $ pure "flex flex-col items-start"

  pageSig /\ _ <- usePage

  ch $ headerComponent

  ch $ el "div" do
    useClass $ pure "overflow-y-auto w-full flex-1"

    ch $ el "div" do
      useClass $ pure "min-h-[calc(100%-8rem)] h-0"

      chSig do
        page <- pageSig

        pure $ case page of
          PageAbout -> aboutPageComponent
          PageWorks -> worksPageComponent
          PageWorkInfo workId -> workInfoPageComponent $ pure workId
          PagePosts -> postsPageComponent
          PagePostInfo postId -> postInfoPageComponent $ pure postId
          PageNotFound path -> notFoundPageComponent $ pure path
          PageLinks -> notFoundPageComponent $ pure "links"
          PageTop -> topPageComponent

    ch footerComponent
