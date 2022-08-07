module Hooks.UseAdjustWindowHeight where

import Prelude

import Data.Tuple.Nested ((/\))
import Effect.Class (liftEffect)
import Jelly (Hook, signal, useEventListener, writeAtom, (:+))
import Web.HTML (window)
import Web.HTML.Window as Window

useAdjustWindowHeight :: forall r. Hook r Unit
useAdjustWindowHeight = do
  w <- liftEffect $ window

  initialWindowHeight <- liftEffect $ Window.innerHeight w

  windowHeightSig /\ windowHeightAtom <- signal initialWindowHeight

  let
    listener = \_ -> do
      newHeight <- Window.innerHeight w
      writeAtom windowHeightAtom newHeight

  useEventListener "resize" listener $
    Window.toEventTarget w

  "style" :+ (\height -> "height:" <> show height <> "px") <$> windowHeightSig
