module Pages.Top where

import Prelude

import Components.Logo (logoComponent)
import Components.NavigationTab (navigationTabComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Page (Page(..))
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, ch, el, text)

topPageComponent :: Component Contexts
topPageComponent = el "div" do
  useClass $ pure
    "fixed top-0 sm:left-[4rem] lg:left-[8rem] h-full w-full pointer-events-none"
  useClass $ pure
    "flex flex-col justify-end sm:justify-center items-center sm:items-start gap-10 pb-[14rem] sm:pb-0"

  ch $ el "div" do
    useClass $ pure "h-16 w-[16rem] sm:h-24 sm:w-[26rem]"
    useClass $ pure
      "flex flex-col justify-center items-center relative"

    ch $ el "div" do
      useColor Reverse Text
      useClass $ pure
        "text-4xl sm:text-6xl font-black font-PassionOne z-20 relative transition-opacity h-12 sm:h-16 flex items-baseline gap-6"
      ch $ logoComponent
      ch $ el "div" do
        useClass $ pure "h-full transform-gpu -skew-x-[9deg]"
        ch $ text $ pure "YUKINET"
      useDelayClass 400 (pure "opacity-0") (pure "opacity-100")

    ch $ el "div" do
      useDelayClass 200 (pure "w-0") (pure "w-full")
      useClass $ pure
        "absolute top-0 left-0 h-full rounded transition-all transform-gpu -skew-x-[9deg]"
      useColor Highlight Background
      useDelayClass 400 (pure "duration-500") (pure "")

  ch $ el "div" do
    useClass $ pure "transition-all"

    useDelayClass 100 (pure "opacity-0") (pure "opacity-100")

    useClass $ pure "text-lg font-medium"
    ch $ text $ pure "ゆきくらげのウェブページ"

  ch $ el "div" do
    useClass $ pure
      "flex sm:flex-col gap-3 items-center sm:items-start relative pointer-events-auto"
    useClass $ pure "transition-all"
    useDelayClass 100 (pure "opacity-0") (pure "opacity-100")

    ch $ navigationTabComponent
      { titleSig: pure "About"
      , refPageSig: pure PageAbout
      , classSig: pure " sm:text-4xl"
      }
    ch $ navigationTabComponent
      { titleSig: pure "Works"
      , refPageSig: pure PageWorks
      , classSig: pure "sm:text-4xl"
      }
    ch $ navigationTabComponent
      { titleSig: pure "Blog"
      , refPageSig: pure PagePosts
      , classSig: pure "sm:text-4xl"
      }
