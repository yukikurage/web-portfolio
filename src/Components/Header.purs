module Components.Header where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor, useColorSig)
import Contexts.Page (usePage)
import Data.Page (Page(..), isParent)
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Hooks.UseLink (useLink)
import Jelly (Component, Signal, ch, el, text)

headerComponent :: Component Contexts
headerComponent = el "div" do
  useClass $ pure "w-full p-6"

  useClass $ pure "flex justify-start items-end gap-4"

  ch $ el "a" do
    pageSig /\ _ <- usePage

    useColor Reverse Text
    useColor Highlight Background

    useLink $ pure PageTop

    useClass $ pure "text-3xl font-black font-Bungee"
    useClass $ pure "py-2 overflow-hidden transition-all"
    useClass $ pure "flex justify-center items-center"
    useClass do
      page <- pageSig
      pure if page == PageTop then "w-0" else "px-4 w-48"

    ch $ text $ pure "YUKINET"

  ch $ el "div" do
    useClass $ pure "flex-grow"
    useClass $ pure "flex flex-row"

    ch $ navTab { titleSig: pure "About", refPageSig: pure PageAbout }
    ch $ navTab { titleSig: pure "Works", refPageSig: pure PageWorks }
    ch $ navTab { titleSig: pure "Blog", refPageSig: pure PagePosts }

navTab
  :: { titleSig :: Signal String, refPageSig :: Signal Page }
  -> Component Contexts
navTab { titleSig, refPageSig } = el "a" do
  useClass $ pure "relative group py-2 px-5"
  useClass $ pure "flex justify-center"
  useClass $ pure "text-2xl font-bold"
  useClass $ pure "transition-all"

  pageSig /\ _ <- usePage

  useLink refPageSig

  let
    isActiveSig = isParent <$> refPageSig <*> pageSig

  useColorSig
    do
      ifM isActiveSig
        do pure Highlight
        do pure Primary
    do pure Text

  ch $ el "div" do
    useClass $ pure "absolute left-1/2 -translate-x-1/2 bottom-0"

    useClass $ ifM isActiveSig
      do pure "w-full h-1"
      do pure "w-3/4 h-0 group-hover:h-1"

    useClass $ pure "transition-all"

    useColorSig
      do
        ifM isActiveSig
          do pure Highlight
          do pure Reverse
      do pure Background

  ch $ text $ titleSig
