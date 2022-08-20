module Hooks.UseMousePosition where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Tuple.Nested (type (/\), (/\))
import Effect.Class (liftEffect)
import Jelly (Hook, Signal, signal, useEventListener, writeAtom)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toEventTarget)
import Web.HTML.Window (document)
import Web.HTML.Window as Window
import Web.UIEvent.MouseEvent (clientX, clientY)
import Web.UIEvent.MouseEvent as ME

useMousePosition :: forall r. Hook r (Signal (Int /\ Int))
useMousePosition = do
  mousePosSig /\ mousePosAtom <- signal (0 /\ 0)
  w <- liftEffect $ window

  let
    listener = \e -> case ME.fromEvent e of
      Just me -> do
        wh <- Window.innerHeight w
        ww <- Window.innerWidth w
        writeAtom mousePosAtom ((clientX me - ww / 2) /\ (clientY me - wh / 2))
      Nothing -> pure unit

  doc <- liftEffect $ document =<< window
  useEventListener "mousemove" listener (toEventTarget doc)

  pure mousePosSig
