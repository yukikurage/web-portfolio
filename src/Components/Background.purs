module Components.Background where

import Prelude

import Components.Image (imageComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Contexts.Page (usePage)
import Data.Array (length, (!!))
import Data.Maybe (fromMaybe)
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Effect.Class (liftEffect)
import Effect.Random (randomInt)
import Hooks.UseClass (useClass)
import Hooks.UseMousePosition (useMousePosition)
import Jelly (Component, Hook, ch, el, (:=))

bgImgList :: Array String
bgImgList =
  [ "img/webp/hina.webp"
  , "img/webp/IrisOut.webp"
  , "img/webp/yukikurage2.webp"
  , "img/webp/comi.webp"
  , "img/webp/20200107.webp"
  , "img/webp/20210504.webp"
  , "img/webp/Dot.webp"
  , "img/webp/thumbnail8.webp"
  ]

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
  useClass $ pure "w-[110%] h-[110%] fixed -top-[5%] -left-[5%] -z-20"
  useColor Disabled Background

  pageSig /\ _ <- usePage

  ch $ imageComponent do
    useMouseMove 100
    i <- liftEffect $ randomInt 0 $ length bgImgList - 1
    useClass $ pure
      "absolute top-1/2 left-1/2 w-full h-full object-cover transition-all duration-500 ease-linear"
    "src" := pure (fromMaybe "/img/webp/hina.webp" $ bgImgList !! i)
    useClass do
      page <- pageSig
      pure $
        if page == PageTop then "opacity-50 blur-sm" else "opacity-40 blur"

  ch $ el "div" do
    useClass $ pure
      "absolute -bottom-[2rem] sm:-top-1/4 -left-[4rem] w-[150%] h-[30rem] sm:w-[40rem] sm:h-[150%] lg:w-[50rem] transition-all shadow-md"
    useClass do
      page <- pageSig
      pure $
        if page == PageTop then "opacity-100 -rotate-[9deg] sm:rotate-[9deg]"
        else "opacity-0 blur -translate-x-20 -rotate-[16deg] sm:rotate-6"

    useColor Primary Background
