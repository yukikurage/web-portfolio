module Pages.NotFound where

import Prelude

import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Hooks.UseClass (useClass)
import Jelly (Component, Signal, ch, el, text, (:=))

notFoundPageComponent :: Signal String -> Component Contexts
notFoundPageComponent pathSig = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col items-center p-12 gap-12"

  ch $ el "div" do
    useClass $ pure "flex flex-col p-20 gap-6"
    useClass $ pure "bg-[#0000ff] text-white rounded-md"

    ch $ el "div" do

      useClass $ pure "text-5xl mb-10"
      ch $ text $ pure "˚‧º·(˚ ˃̣̣̥᷄⌓˂̣̣̥᷅ )‧º·˚ "

    ch $ el "div" do
      useClass $ pure "text-lg"
      ch $ text $
        ( \p -> "Seems that you came to a page that doesn't exist. (#" <> p <>
            ")"
        ) <$>
          pathSig
    ch $ el "div" do
      useClass $ pure "flex flex-row gap-3 items-start"
      ch $ el "img" do
        "src" := pure "./img/QR.png"
        useClass $ pure "w-24 h-24 mt-2"
      ch $ el "div" do
        ch $ text $ pure "code: 404"
