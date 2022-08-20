module Hooks.UseTypingString where

import Prelude

import Data.String (length, take)
import Data.Tuple.Nested ((/\))
import Effect.Class (liftEffect)
import Jelly (Hook, Signal, readSignal, signal, useInterval, writeAtom)

useTypingString
  :: forall r. Signal String -> Hook r (Signal String)
useTypingString targetSig = do
  stateSig /\ stateAtom <- signal ""

  useInterval 70 do
    targetStr <- readSignal targetSig
    stateStr <- readSignal stateSig
    liftEffect $ when (targetStr /= stateStr)
      if take (length stateStr) targetStr == stateStr then
        writeAtom stateAtom $ take (length stateStr + 1) targetStr
      else
        writeAtom stateAtom $ take (length stateStr - 1) stateStr

  pure $ stateSig
