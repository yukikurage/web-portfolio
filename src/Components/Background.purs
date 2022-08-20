module Components.Background where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Contexts.Page (usePage)
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Hooks.UseMousePosition (useMousePosition)
import Jelly (Component, Hook, ch, el, (:=))

useMouseMove :: Int -> Hook Contexts Unit
useMouseMove n = do
  mousePosSig <- useMousePosition
  "style" := do
    mousePosX /\ mousePosY <- mousePosSig

    let
      mousePosXDiff = mousePosX / n
      mousePosYDiff = mousePosY / n

    pure $ "transform:translate(calc(-50% + " <> show mousePosXDiff
      <> "px), calc(-50% + "
      <> show mousePosYDiff
      <> "px));"

backgroundComponent :: Component Contexts
backgroundComponent = el "div" do
  useClass $ pure "w-full h-full fixed top-0 left-0 -z-20 "
  useColor Primary Background

  ch $ el "div" do
    pageSig /\ _ <- usePage

    useClass $ pure
      "w-full h-full fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 -z-10 opacity-50 transition-all duration-500 ease-linear"
    useClass do
      page <- pageSig
      pure $ if page == PageTop then "opacity-60" else "opacity-10"

    ch $ el "div" do
      useMouseMove 50
      useDelayClass 100
        do pure "w-0 h-0"
        do pure "w-[1400px] h-[1400px]"
      useClass $ pure
        "absolute top-1/2 left-1/2 rounded-full transition-all"
      useDelayClass 200 (pure "duration-[2000ms]")
        (pure "")
      useColor Highlight Background

    ch $ el "div" do
      useMouseMove 50
      useDelayClass 300
        do pure "w-0 h-0"
        do pure "w-[1200px] h-[1200px]"
      useClass $ pure
        "absolute top-1/2 left-1/2 rounded-full transition-all"
      useDelayClass 400 (pure "duration-[2000ms]")
        (pure "")
      useColor Primary Background

    ch $ el "div" do
      useMouseMove 50
      useDelayClass 500
        do pure "w-0 h-0"
        do pure "w-[1100px] h-[1100px]"
      useClass $ pure
        "absolute top-1/2 left-1/2 rounded-full transition-all"
      useDelayClass 600 (pure "duration-[2000ms]")
        (pure "")
      useColor Highlight Background

    ch $ el "div" do
      useMouseMove 50
      useDelayClass 700
        do pure "w-0 h-0"
        do pure "w-[1050px] h-[1050px]"
      useClass $ pure
        "absolute top-1/2 left-1/2 rounded-full transition-all"
      useDelayClass 800 (pure "duration-[2000ms]")
        (pure "")
      useColor Primary Background
