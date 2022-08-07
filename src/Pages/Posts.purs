module Pages.Posts where

import Prelude

import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Jelly (Component, ch, el, text)

postsPageComponent :: Component Contexts
postsPageComponent = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col"

  ch $ pageTitleComponent $ pure "Blog"

  ch $ text $ pure "Posts Page"
