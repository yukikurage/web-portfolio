module Components.Footer where

import Prelude

import Components.ForeignLink (foreignLinkComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorMode(..), ColorScheme(..), ColorTarget(..), getColor, useColorMode, useColorSig)
import Contexts.Page (usePage)
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Jelly (Component, Hook, Signal, ch, el, on, readSignal, text, writeAtom)

useFooterTextColor :: Hook Contexts Unit
useFooterTextColor = do
  pageSig /\ _ <- usePage

  useColorSig
    do
      ifM (eq PageTop <$> pageSig)
        do pure Transparent
        do pure Reverse
    do pure Text

footerComponent :: Component Contexts
footerComponent = el "div" do
  useClass $ pure "w-full h-[12rem] sm:h-[8rem] py-8 px-12"

  useFooterTextColor

  pageSig /\ _ <- usePage
  useColorSig
    do
      ifM (eq PageTop <$> pageSig)
        do pure Transparent
        do pure Reverse
    do pure Background

  useClass $ pure "text-opacity-80"
  useClass $ pure
    "flex flex-col sm:flex-row justify-end sm:justify-between items-center sm:items-end gap-8"

  ch copyRight
  ch colorThemes

copyRight :: Component Contexts
copyRight = el "div" do
  useClass $ pure "text-opacity-80"
  useClass $ pure "flex flex-col gap-3"

  ch $ el "p" do
    useClass $ pure "flex flex-row gap-2 items-baseline"
    ch $ foreignLinkComponent
      do
        pure "https://github.com/yukikurage/web-portfolio"
      do
        pure $ el "i" do
          useFooterTextColor
          useClass $ pure
            "text-opacity-80 hover:text-opacity-60 transition-colors font-bold"
          useClass $ pure "fab fab fa-github fa-2x"
    ch $ text $ pure "made by "
    ch $ foreignLinkComponent
      do
        pure "https://github.com/yukikurage/purescript-jelly"
      do
        pure $ el "p" do
          useFooterTextColor
          useClass $ pure
            "text-opacity-80 hover:text-opacity-60 transition-colors font-bold"
          ch $ text $ pure "Jelly"
  ch $ el "p" $ ch $ text $ pure "©2022-2022 YUKINET"

colorThemes :: Component Contexts
colorThemes = el "div" do
  useClass $ pure "flex flex-row gap-3"
  ch $ colorThemeToggleButton $ pure Light
  ch $ colorThemeToggleButton $ pure Summer
  ch $ colorThemeToggleButton $ pure Dark
  ch $ colorThemeToggleButton $ pure Winter
  ch $ colorThemeToggleButton $ pure Hacker

colorThemeToggleButton
  :: Signal ColorMode
  -> Component Contexts
colorThemeToggleButton colorModeSig =
  el "button" do
    currentColorModeSig /\ colorThemeAtom <- useColorMode

    let
      isCurrentColorThemeSig = eq <$> currentColorModeSig <*> colorModeSig

    useClass $ pure "hover:opacity-60 transition-opacity font-bold rounded-sm"
    useClass $ do
      isCurrentColorTheme <- isCurrentColorThemeSig
      pure $ if isCurrentColorTheme then "opacity-60" else "opacity-100"

    on "click" \_ -> do
      colorMode <- readSignal colorModeSig
      writeAtom colorThemeAtom colorMode

    useClass $ pure "w-6 h-6"
    let
      exampleColor = do
        colorMode <- colorModeSig
        pure $ getColor colorMode Highlight Background
    useClass exampleColor
