module Hooks.UsePopIn where

import Prelude

import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Hook)

usePopIn :: forall r. Hook r Unit
usePopIn = do
  useClass $ pure "transition-all relative"
  useDelayClass 20
    do pure "scale-90 opacity-0 -top-4"
    do pure "scale-100 opacity-100 top-0"
