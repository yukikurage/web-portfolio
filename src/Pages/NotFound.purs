module Pages.NotFound where

import Prelude

import Contexts (Contexts)
import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Component, Signal, ch, el, signal, text, useTimeout, writeAtom, (:=))

notFoundPageComponent :: Signal String -> Component Contexts
notFoundPageComponent pathSig = el "div" do
  useClass $ pure "w-full"

  useClass $ pure "flex flex-col items-center p-12 gap-12"

  ch $ el "div" do
    useClass $ pure "flex flex-col p-20 gap-6 relative overflow-hidden"
    useDelayClass 500 (pure "bg-[#000000]") (pure "bg-[#0000aa]")
    useClass $ pure
      "text-gray-300 rounded-md bg-gradient-radial bg-[#0000aa] shadow-inner"

    ch $ el "div" do
      useDelayClass 500 (pure "opacity-0") (pure "")

      useClass $ pure
        "text-2xl font-sans font-bold md:text-5xl mb-10 animate-glitch-text scale-y-90"
      ch $ text $ pure "˚‧º·(˚ ˃̣̣̥᷄⌓˂̣̣̥᷅ )‧º·˚ "

    ch $ el "div" do
      useDelayClass 500 (pure "opacity-0") (pure "")

      useClass $ pure "text-lg font-mono animate-glitch-text scale-y-90"
      ch $ text $
        ( \p -> "Seems that you came to a page that doesn't exist. (#" <> p <>
            ")"
        ) <$>
          pathSig
    ch $ el "div" do
      useDelayClass 500 (pure "opacity-0") (pure "")
      useClass $ pure
        "flex font-mono flex-row gap-3 items-start scale-y-90 h-24"
      ch $ el "div" do
        useClass $ pure "animate-glitch opacity-80"
        useClass $ pure
          "w-24 mt-2 overflow-hidden ease-linear"

        hSig /\ hAtom <- signal "h-0"

        useTimeout 600 $ writeAtom hAtom "h-4"
        useTimeout 1200 $ writeAtom hAtom "h-20"
        useTimeout 1500 $ writeAtom hAtom "h-24"

        useClass hSig

        ch $ el "img" do
          "src" := pure "./img/QR.png"
      ch $ el "div" do
        useClass $ pure "animate-glitch-text"
        ch $ text $ pure "code: 404"

    ch $ el "div" do
      useClass $ pure
        "absolute top-0 left-0 w-full h-full z-10 bg-stripe-yb opacity-20 bg-stripe-y pointer-events-none"
      useClass $ pure "flex flex-col"
