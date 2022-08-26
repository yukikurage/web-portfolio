module Hooks.UseDialog where

import Prelude

import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Class (liftEffect)
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, Hook, Signal, ch, chSig, el, on, useContext, useUnmountEffect, (:=))
import Jelly.Data.Component (runComponent)
import Web.DOM.Element (closest, fromEventTarget, toNode)
import Web.DOM.Node (appendChild, removeChild)
import Web.DOM.ParentNode (QuerySelector(..), querySelector)
import Web.Event.Event (preventDefault, target)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.HTML.Window (document)

useDialog
  :: Effect Unit
  -> Signal (Component Contexts)
  -> Hook Contexts Unit
useDialog onClose componentSig = do
  context <- useContext

  node /\ unmount <- liftEffect $ flip runComponent context $ el "div" do

    useClass $ pure "fixed inset-0 p-12 bg-opacity-30 overflow-auto"
    useClass $ pure "flex flex-col items-center justify-center"

    useDelayClass 100 (pure "opacity-0") $ pure "opacity-100"

    useColor Reverse Background

    on "click" \e -> case fromEventTarget =<< target e of
      Just elem -> do
        closestMaybe <- closest (QuerySelector "#dialog-container-outer") elem
        case closestMaybe of
          Just _ -> pure unit
          Nothing -> onClose
      Nothing -> pure unit

    ch $ el "div" do
      "id" := pure "dialog-container-outer"

      useClass $ pure "relative w-fit h-fit"

      chSig componentSig

  maybeDialogRoot <- liftEffect $
    querySelector (QuerySelector "#dialog-container-root")
      <<< toParentNode
      =<< document
      =<< window

  liftEffect $ case maybeDialogRoot of
    Just dialogRoot -> do
      appendChild node $ toNode dialogRoot
    Nothing -> pure unit

  useUnmountEffect do
    case maybeDialogRoot of
      Just dialogRoot -> do
        removeChild node $ toNode dialogRoot
        pure unit
      Nothing -> pure unit
    unmount
