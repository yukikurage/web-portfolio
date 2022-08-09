module Components.ForeignLink where

import Prelude

import Contexts (Contexts)
import Jelly (Component, Signal, chSig, el, (:=))

foreignLinkComponent
  :: Signal String -> Signal (Component Contexts) -> Component Contexts
foreignLinkComponent linkSig componentSig = el "a" do
  "href" := linkSig
  "target" := pure "_blank"
  "rel" := pure "noopener noreferrer"

  chSig componentSig
