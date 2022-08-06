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

data ColorMode = Light | Dark
data ColorScheme = Primary | Highlight | Reverse | Disabled
data ColorTarget = Text | Background

derive instance Eq ColorMode
instance Show ColorMode where
  show Light = "light"
  show Dark = "dark"

readColorMode :: String -> Maybe ColorMode
readColorMode "light" = Just Light
readColorMode "dark" = Just Dark
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
      Text -> "text-slate-900"
      Background -> "bg-white"
    Highlight -> case _ of
      Text -> "text-slate-900"
      Background -> "bg-pink-500"
    Reverse -> case _ of
      Text -> "text-white"
      Background -> "bg-slate-900"
    Disabled -> case _ of
      Text -> "text-slate-600"
      Background -> "bg-white bg-opacity-80"
  Dark -> case _ of
    Primary -> case _ of
      Text -> "text-white"
      Background -> "bg-slate-900"
    Highlight -> case _ of
      Text -> "text-white"
      Background -> "bg-pink-600"
    Reverse -> case _ of
      Text -> "text-slate-900"
      Background -> "bg-white"
    Disabled -> case _ of
      Text -> "text-slate-300"
      Background -> "bg-slate-900 bg-opacity-80"

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
