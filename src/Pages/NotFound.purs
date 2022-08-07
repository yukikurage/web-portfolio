module Pages.NotFound where

import Prelude

import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Jelly (Component, Signal, ch, el, text)

notFoundPageComponent :: Signal String -> Component Contexts
notFoundPageComponent pathSig = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col"

  ch $ pageTitleComponent $ pure "NOT FOUND"

  ch $ text $ do
    path <- pathSig
    pure $ "Page Not Found:" <> path
