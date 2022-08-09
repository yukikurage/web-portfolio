module Pages.Works where

import Prelude

import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, el, text)

worksPageComponent :: Component Contexts
worksPageComponent = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col p-12"

  ch $ pageTitleComponent $ pure "Works"

  ch $ text $ pure "Works Page"
