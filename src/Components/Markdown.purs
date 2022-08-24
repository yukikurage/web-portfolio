module Components.Markdown where

import Prelude

import Contexts (Contexts)
import Effect (Effect)
import Effect.Class (liftEffect)
import Hooks.UseClass (useClass)
import Hooks.UseInnerHTML (useInnerHTML)
import Jelly (Component, Signal, el)

foreign import parseMarkdown :: String -> Effect String

type Props = Signal String

markdownComponent :: Props -> Component Contexts
markdownComponent value = el "div" do
  useClass $ pure "markdown"

  useInnerHTML do
    v <- value
    liftEffect $ parseMarkdown v

  pure unit
