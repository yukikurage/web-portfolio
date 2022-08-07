module Contexts.ColorMode where

import Prelude

import Data.Maybe (Maybe(..), fromMaybe)
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Effect.Class (liftEffect)
import Hooks.UseClass (useClass)
import Jelly (Atom, Hook, Signal, launch_, signal, useContext)
import Web.HTML (window)
import Web.HTML.Window (localStorage)
import Web.Storage.Storage (getItem, setItem)

data ColorMode = Light | Dark | Summer | Winter | Hacker
data ColorScheme = Primary | Highlight | Reverse | Disabled
data ColorTarget = Text | Background

derive instance Eq ColorMode
instance Show ColorMode where
  show Light = "light"
  show Dark = "dark"
  show Summer = "summer"
  show Winter = "winter"
  show Hacker = "hacker"

readColorMode :: String -> Maybe ColorMode
readColorMode "light" = Just Light
readColorMode "dark" = Just Dark
readColorMode "summer" = Just Summer
readColorMode "winter" = Just Winter
readColorMode "hacker" = Just Hacker
readColorMode _ = Nothing

defaultColorMode :: ColorMode
defaultColorMode = Light

type ColorModeContext r =
  ( colorMode :: Signal ColorMode /\ Atom ColorMode
  | r
  )

useColorMode
  :: forall r
   . Hook (Record (ColorModeContext r))
       (Signal ColorMode /\ Atom ColorMode)
useColorMode = do
  { colorMode } <- useContext
  pure colorMode

provideColorMode
  :: Effect (Signal ColorMode /\ Atom ColorMode)
provideColorMode = do
  storage <- liftEffect $ localStorage =<< window
  cmStr <- liftEffect $ getItem "colorMode" storage
  let
    savedColorMode = fromMaybe defaultColorMode $ readColorMode =<< cmStr

  colorModeSig /\ colorModAtom <- signal savedColorMode

  launch_ do
    colorMode <- colorModeSig
    liftEffect $ setItem "colorMode" (show colorMode) storage

  pure $ colorModeSig /\ colorModAtom

getColor :: ColorMode -> ColorScheme -> ColorTarget -> String
getColor = case _ of
  Light -> case _ of
    Primary -> case _ of
      Text -> "text-neutral-900"
      Background -> "bg-white"
    Highlight -> case _ of
      Text -> "text-rose-600"
      Background -> "bg-rose-600"
    Reverse -> case _ of
      Text -> "text-white"
      Background -> "bg-neutral-800"
    Disabled -> case _ of
      Text -> "text-neutral-600"
      Background -> "bg-white bg-opacity-80"
  Dark -> case _ of
    Primary -> case _ of
      Text -> "text-white"
      Background -> "bg-slate-900"
    Highlight -> case _ of
      Text -> "text-fuchsia-500"
      Background -> "bg-fuchsia-500"
    Reverse -> case _ of
      Text -> "text-slate-900"
      Background -> "bg-white"
    Disabled -> case _ of
      Text -> "text-slate-300"
      Background -> "bg-slate-900 bg-opacity-80"
  Summer -> case _ of
    Primary -> case _ of
      Text -> "text-slate-800"
      Background -> "bg-white"
    Highlight -> case _ of
      Text -> "text-sky-600"
      Background -> "bg-sky-600"
    Reverse -> case _ of
      Text -> "text-white"
      Background -> "bg-slate-700"
    Disabled -> case _ of
      Text -> "text-slate-500"
      Background -> "bg-white bg-opacity-80"
  Winter -> case _ of
    Primary -> case _ of
      Text -> "text-white"
      Background -> "bg-stone-900"
    Highlight -> case _ of
      Text -> "text-stone-400"
      Background -> "bg-stone-400"
    Reverse -> case _ of
      Text -> "text-stone-900"
      Background -> "bg-stone-100"
    Disabled -> case _ of
      Text -> "text-stone-300"
      Background -> "bg-stone-900 bg-opacity-80"
  Hacker -> case _ of
    Primary -> case _ of
      Text -> "text-white"
      Background -> "bg-black"
    Highlight -> case _ of
      Text -> "text-green-500"
      Background -> "bg-green-500"
    Reverse -> case _ of
      Text -> "text-black"
      Background -> "bg-white"
    Disabled -> case _ of
      Text -> "text-neutral-300"
      Background -> "bg-black bg-opacity-80"

useColorSig
  :: forall r
   . Signal ColorScheme
  -> Signal ColorTarget
  -> Hook (Record (ColorModeContext r)) Unit
useColorSig schemeSig targetSig = do
  colorModeSig /\ _ <- useColorMode
  useClass do
    colorMode <- colorModeSig
    scheme <- schemeSig
    target <- targetSig
    pure $ getColor colorMode scheme target

useColor
  :: forall r
   . ColorScheme
  -> ColorTarget
  -> Hook (Record (ColorModeContext r)) Unit
useColor scheme target = do
  colorModeSig /\ _ <- useColorMode
  useClass do
    colorMode <- colorModeSig
    pure $ getColor colorMode scheme target
