module Components.Markdown where

import Prelude

import Contexts (Contexts)
import Effect (Effect)
import Effect.Class (liftEffect)
import Hooks.UseClass (useClass)
import Jelly (Component, Signal, el, useRef, useSignal)
import Web.DOM (Element)

foreign import parseMarkdown :: Element -> String -> Effect Unit

type Props = Signal String

markdownComponent :: Props -> Component Contexts
markdownComponent value = el "div" do
  ref <- useRef

  useClass $ pure "markdown"

  useSignal do
    v <- value
    liftEffect $ parseMarkdown ref v

  pure unit
