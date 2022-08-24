module Components.Markdown where

import Prelude

import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Hooks.UseInnerHTML (useInnerHTML)
import Jelly (Component, Signal, el)

foreign import parseMarkdown :: String -> String

type Props = Signal String

markdownComponent :: Props -> Component Contexts
markdownComponent value = el "div" do
  useClass $ pure "markdown"

  useInnerHTML do
    v <- value
    pure $ parseMarkdown v

  pure unit
