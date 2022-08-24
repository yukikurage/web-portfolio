module Hooks.UseInnerHTML where

import Prelude

import Contexts (Contexts)
import Effect (Effect)
import Effect.Class (liftEffect)
import Jelly (Hook, Signal, useRef, useSignal)
import Web.DOM (Element)

foreign import setInnerHTML :: Element -> String -> Effect Unit

useInnerHTML :: Signal String -> Hook Contexts Unit
useInnerHTML htmlSig = do
  ref <- useRef

  useSignal do
    html <- htmlSig
    liftEffect $ setInnerHTML ref html
