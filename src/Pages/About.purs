module Pages.About where

import Prelude

import Contexts (Contexts)
import Jelly (Component, ch, el, text)

aboutPageComponent :: Component Contexts
aboutPageComponent = el "div" do
  ch $ text $ pure "About Page"
