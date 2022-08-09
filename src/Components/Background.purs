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
import Jelly (Component, ch, el, (:=))

backgroundComponent :: Component Contexts
backgroundComponent = el "div" do

  useClass $ pure "w-full h-full fixed top-0 left-0 -z-20 "
  useColor Primary Background

  ch $ el "div" do
    mousePosSig <- useMousePosition
    "style" := do
      mousePosX /\ mousePosY <- mousePosSig

      let
        mousePosXDiff = mousePosX / 100
        mousePosYDiff = mousePosY / 100

      pure $ "transform:translate(calc(-50% + " <> show mousePosXDiff
        <> "px), calc(-50% + "
        <> show mousePosYDiff
        <> "px));"

    pageSig /\ _ <- usePage

    useClass $ pure
      "w-full h-full fixed top-1/2 left-1/2 -z-10 opacity-50 transition-all duration-500 ease-linear"
    useClass do
      page <- pageSig
      pure $ if page == PageTop then "opacity-60" else "opacity-10"

    ch $ el "div" do
      useDelayClass 100
        do pure "w-0 h-0 rotate-[20deg]"
        do pure "w-[1000px] h-[1000px] rotate-[30deg]"
      useClass $ pure
        "absolute left-0 top-0 -translate-x-72 -translate-y-96 transition-all ease-in-out rounded-3xl"
      useDelayClass 1000 (pure "duration-[2000ms]")
        (pure "")
      useColor Highlight Background

    ch $ el "div" do
      useDelayClass 500
        do pure "w-0 h-0 -rotate-[30deg]"
        do pure "w-[500px] h-[500px] rotate-[10deg]"
      useClass $ pure
        "absolute left-0 top-0 -translate-x-20 -translate-y-40 transition-all ease-in-out rounded-3xl"
      useDelayClass 1000 (pure "duration-[2000ms]")
        (pure "")
      useColor Primary Background

    ch $ el "div" do
      useDelayClass 400
        do pure "w-0 h-0 rotate-[40deg]"
        do pure "w-[800px] h-[800px] -rotate-[10deg]"
      useClass $ pure
        "absolute bottom-0 right-0 translate-x-40 translate-y-32 transition-all ease-in-out rounded-3xl"
      useDelayClass 1000 (pure "duration-[2000ms]")
        (pure "")
      useColor Highlight Background

    ch $ el "div" do
      useDelayClass 900
        do pure "w-0 h-0 rotate-[10deg]"
        do pure "w-[400px] h-[400px]"
      useClass $ pure
        "absolute bottom-0 right-0 translate-x-32 translate-y-8 -rotate-[20deg] transition-all ease-in-out rounded-3xl"
      useDelayClass 1000 (pure "duration-[2000ms]")
        (pure "")
      useColor Primary Background
