module Hooks.UseDelayClass where

import Prelude

import Data.Tuple.Nested ((/\))
import Hooks.UseClass (useClass)
import Jelly (Hook, Signal, signal, useTimeout, writeAtom)

useDelayClass :: forall r. Int -> Signal String -> Signal String -> Hook r Unit
useDelayClass time before after = do
  isChangedSig /\ isChangedAtom <- signal false

  useTimeout time do
    writeAtom isChangedAtom true

  useClass do
    isChanged <- isChangedSig
    if isChanged then
      after
    else
      before
