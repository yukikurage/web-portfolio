module Components.Background where

import Prelude

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
  [ "img/hina.png"
  , "img/IrisOut.png"
  , "img/20220508.png"
  , "img/yukikurage2.png"
  , "img/comi.png"
  , "img/20200920.png"
  , "img/20210504.png"
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
  useClass $ pure "w-full h-full fixed top-0 left-0 -z-20"
  useColor Primary Background

  ch $ el "div" do
    useMouseMove 50
    pageSig /\ _ <- usePage

    useClass $ pure
      "w-[110%] h-[110%] fixed top-1/2 left-1/2 -z-10 opacity-50 transition-all duration-500 ease-linear"
    useClass do
      page <- pageSig
      pure $ if page == PageTop then "opacity-50 blur-sm" else "opacity-40 blur"

    ch $ el "img" do
      i <- liftEffect $ randomInt 0 $ length bgImgList - 1
      useClass $ pure "w-full h-full object-cover"
      "src" := pure (fromMaybe "/img/hina.png" $ bgImgList !! i)

-- ch $ el "div" do
--   useDelayClass 300
--     do pure "w-[400%]"
--     do pure "w-[90%]"
--   useClass $ pure
--     "absolute top-1/2 left-1/2 rounded-full transition-all -translate-x-1/2 -translate-y-1/2 aspect-square shadow-lg"
--   useDelayClass 500 (pure "duration-[2000ms]")
--     (pure "")
--   useColor Highlight Background

-- ch $ el "div" do
--   useDelayClass 100
--     do pure "w-[400%]"
--     do pure "w-[70%]"
--   useClass $ pure
--     "absolute top-1/2 left-1/2 rounded-full transition-all -translate-x-1/2 -translate-y-1/2 aspect-square shadow-lg"
--   useDelayClass 300 (pure "duration-[2000ms]")
--     (pure "")
--   useColor Primary Background

-- ch $ el "div" do
--   useDelayClass 200
--     do pure "w-0"
--     do pure "w-[60%]"
--   useClass $ pure
--     "absolute top-1/2 left-1/2 rounded-full transition-all -translate-x-1/2 -translate-y-1/2 aspect-square shadow-lg"
--   useDelayClass 400 (pure "duration-[2000ms]")
--     (pure "")
--   useColor Highlight Background

-- ch $ el "div" do
--   useDelayClass 300
--     do pure "w-0"
--     do pure "w-[58%]"
--   useClass $ pure
--     "absolute top-1/2 left-1/2 rounded-full transition-all -translate-x-1/2 -translate-y-1/2 aspect-square shadow-lg"
--   useDelayClass 500 (pure "duration-[2000ms]")
--     (pure "")
--   useColor Primary Background
