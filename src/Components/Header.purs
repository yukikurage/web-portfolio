module Components.Header
  ( headerComponent
  ) where

import Prelude

import Components.Logo (logoComponent)
import Components.NavigationTab (navigationTabComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Contexts.Page (usePage)
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Hooks.UseInnerHTML (useInnerHTML)
import Hooks.UseLink (useLink)
import Jelly (Component, ch, el, text)

headerComponent :: Component Contexts
headerComponent = el "div" do
  pageSig /\ _ <- usePage
  useClass do
    page <- pageSig
    pure if page == PageTop then "-top-20" else "top-0"

  useClass $ pure "relative w-full p-6 transition-all"

  useClass $ pure "flex justify-start items-end gap-4"

  ch $ el "a" do
    useColor Reverse Text
    useColor Highlight Background

    useLink $ pure PageTop

    useClass $ pure "text-3xl font-black font-Bungee"
    useClass $ pure "py-2 overflow-hidden transition-all rounded shadow-md"
    useClass $ pure "flex justify-center items-center gap-2"
    useClass $ pure "h-12 w-24"
    useClass $ pure "stroke-current"

    ch $ logoComponent

  ch $ el "div" do
    useClass $ pure "flex-grow"
    useClass $ pure "flex flex-row"

    ch $ navigationTabComponent
      { titleSig: pure "About"
      , refPageSig: pure PageAbout
      , classSig: pure ""
      }
    ch $ navigationTabComponent
      { titleSig: pure "Works"
      , refPageSig: pure PageWorks
      , classSig: pure ""
      }
    ch $ navigationTabComponent
      { titleSig: pure "Blog"
      , refPageSig: pure PagePosts
      , classSig: pure ""
      }
