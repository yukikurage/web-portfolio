module Pages.NotFound where

import Prelude

import Contexts (Contexts)
import Jelly (Component, Signal, ch, el, text)

notFoundPageComponent :: Signal String -> Component Contexts
notFoundPageComponent pathSig = el "div" do
  ch $ text $ do
    path <- pathSig
    pure $ "Page Not Found:" <> path
