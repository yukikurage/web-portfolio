module Components.Footer where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorMode(..), ColorScheme(..), ColorTarget(..), getColor, useColorMode, useColorSig)
import Contexts.Page (usePage)
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Jelly (Component, Hook, Signal, ch, chSig, el, on, readSignal, text, writeAtom, (:=))

useFooterColor :: Hook Contexts Unit
useFooterColor = do
  pageSig /\ _ <- usePage

  useColorSig
    do
      ifM (eq PageTop <$> pageSig)
        do pure Primary
        do pure Reverse
    do pure Text
  useColorSig
    do
      ifM (eq PageTop <$> pageSig)
        do pure Primary
        do pure Reverse
    do pure Background

footerComponent :: Component Contexts
footerComponent = el "div" do
  useClass $ pure "w-full h-32 py-8 px-12"

  useFooterColor

  useClass $ pure "text-opacity-80"
  useClass $ pure "flex flex-row justify-between items-end"

  ch copyRight
  ch colorThemes

copyRight :: Component Contexts
copyRight = el "div" do
  useClass $ pure "text-opacity-70"
  useClass $ pure "flex flex-col gap-3"

  ch $ el "p" do
    useClass $ pure "flex flex-row gap-2 items-baseline"
    ch $ linkText
      do
        pure "https://github.com/yukikurage/web-portfolio"
      do
        pure $ el "i" do
          useClass $ pure "fa-brands fa-brands fa-github fa-2x"
    ch $ text $ pure "made by "
    ch $ linkText
      do
        pure "https://github.com/yukikurage/purescript-jelly"
      do
        pure $ text $ pure "Jelly"
  ch $ el "p" $ ch $ text $ pure "©2022-2022 YUKINET"

linkText :: Signal String -> Signal (Component Contexts) -> Component Contexts
linkText linkSig componentSig = el "a" do
  useFooterColor
  useClass $ pure
    "text-opacity-70 hover:text-opacity-100 transition-colors font-bold"

  "href" := linkSig
  "target" := pure "_blank"
  "rel" := pure "noopener noreferrer"

  chSig componentSig

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

    useClass $ pure "hover:opacity-100 transition-opacity font-bold"
    useClass $ do
      isCurrentColorTheme <- isCurrentColorThemeSig
      pure $ if isCurrentColorTheme then "opacity-100" else "opacity-80"

    on "click" \_ -> do
      colorMode <- readSignal colorModeSig
      writeAtom colorThemeAtom colorMode

    useClass $ pure "w-6 h-6"
    let
      exampleColor = do
        colorMode <- colorModeSig
        pure $ getColor colorMode Highlight Background
    useClass exampleColor
