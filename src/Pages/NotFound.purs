module Pages.NotFound where

import Prelude

import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, Signal, ch, el, text)

notFoundPageComponent :: Signal String -> Component Contexts
notFoundPageComponent pathSig = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col items-center p-12 gap-12"

  ch $ pageTitleComponent $ pure "NOT FOUND"

  ch $ el "div" do
    useClass $ pure "flex flex-col p-40 gap-20"
    useClass $ pure "bg-[#0000ff] text-white rounded-md"
    usePopIn

    ch $ el "div" do

      useClass $ pure "text-5xl"
      ch $ text $ pure "˚‧º·(˚ ˃̣̣̥᷄⌓˂̣̣̥᷅ )‧º·˚ "

    ch $ el "div" do
      useClass $ pure "text-2xl"
      ch $ text $
        ( \p -> "Seems that you came to a page that doesn't exist. (#" <> p <>
            ")"
        ) <$>
          pathSig
    ch $ el "div" do
      ch $ text $ pure "code: 404"
