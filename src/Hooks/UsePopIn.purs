module Hooks.UsePopIn where

import Prelude

import Jelly (Hook)

usePopIn :: forall r. Hook r Unit
usePopIn = pure unit
