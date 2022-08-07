module Pages.Work where

import Prelude

import Contexts (Contexts)
import Jelly (Component, ch, el, text)

worksPageComponent :: Component Contexts
worksPageComponent = el "div" do
  ch $ text $ pure "Works Page"
