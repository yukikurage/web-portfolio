module Hooks.UsePopIn where

import Prelude

import Hooks.UseClass (useClass)
import Hooks.UseDelayClass (useDelayClass)
import Jelly (Hook)

usePopIn :: forall r. Hook r Unit
usePopIn = do
  useClass $ pure "transition-opacity"
  useDelayClass 10
    do pure "opacity-0"
    do pure "opacity-100"
