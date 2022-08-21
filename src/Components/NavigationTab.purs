module Components.NavigationTab where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColorSig)
import Contexts.Page (usePage)
import Data.Page (Page, isParent)
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Hooks.UseLink (useLink)
import Jelly (Component, Signal, ch, el, text)

navigationTabComponent
  :: { titleSig :: Signal String
     , refPageSig :: Signal Page
     , classSig :: Signal String
     }
  -> Component Contexts
navigationTabComponent { titleSig, refPageSig, classSig } = el "a" do
  useClass $ pure "relative group py-2 px-5"
  useClass $ pure "flex justify-center"
  useClass $ pure "text-2xl font-bold"
  useClass $ pure "transition-all"
  useClass $ classSig

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
