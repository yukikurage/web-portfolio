module Hooks.UseClass where

import Prelude

import Data.String (joinWith)
import Jelly (Hook, Signal, (:+))

useClass :: forall r. Signal String -> Hook r Unit
useClass cssSig = do
  "class" :+ do
    css <- cssSig
    pure $ " " <> css

useClasses :: forall r. Signal (Array String) -> Hook r Unit
useClasses cssSig = do
  "class" :+ do
    css <- cssSig
    pure $ " " <> joinWith " " css
