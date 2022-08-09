module Pages.NotFound where

import Prelude

import Contexts (Contexts)
import Data.Array (replicate)
import Hooks.UseClass (useClass)
import Jelly (Component, Signal, ch, chs, el, text, (:=))

notFoundPageComponent :: Signal String -> Component Contexts
notFoundPageComponent pathSig = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col items-center p-12 gap-12"

  ch $ el "div" do
    useClass $ pure "flex flex-col p-20 gap-6 relative overflow-hidden"
    useClass $ pure
      "bg-[#0000ff] text-white text-opacity-80 rounded-md bg-gradient-radial from-[#0000ff] to-[#0000cc]"

    ch $ el "div" do

      useClass $ pure
        "text-2xl font-Rubik font-black md:text-5xl mb-10 animate-glitch-text"
      ch $ text $ pure "˚‧º·(˚ ˃̣̣̥᷄⌓˂̣̣̥᷅ )‧º·˚ "

    ch $ el "div" do
      useClass $ pure "text-lg font-mono animate-glitch-text"
      ch $ text $
        ( \p -> "Seems that you came to a page that doesn't exist. (#" <> p <>
            ")"
        ) <$>
          pathSig
    ch $ el "div" do
      useClass $ pure
        "flex font-mono flex-row gap-3 items-start"
      ch $ el "img" do
        useClass $ pure "animate-glitch opacity-80"
        "src" := pure "./img/QR.png"
        useClass $ pure "w-24 h-24 mt-2"
      ch $ el "div" do
        useClass $ pure "animate-glitch-text"
        ch $ text $ pure "code: 404"

    ch $ el "div" do
      useClass $ pure "absolute top-0 left-0 w-full h-full z-10 "
      useClass $ pure "flex flex-col"
      chs $ replicate 100 $ el "div" do
        useClass $ pure "flex-1 overflow-hidden"

        ch $ el "div" do
          useClass $ pure
            "h-[1px] bg-[#000000] opacity-20"
