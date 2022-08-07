module Pages.About where

import Prelude

import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, el, text)

aboutPageComponent :: Component Contexts
aboutPageComponent = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col"

  ch $ pageTitleComponent $ pure "About"

  ch $ text $ pure "About Page"
