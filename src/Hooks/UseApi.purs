module Hooks.UseApi where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Tuple.Nested (type (/\), (/\))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Jelly (Hook, Signal, signal, writeAtom)

data FetchStatus a = Fetched a | Failed | NotFetched

derive instance Eq a => Eq (FetchStatus a)
derive instance Ord a => Ord (FetchStatus a)

useApi
  :: forall a req r
   . Eq a
  => (req -> Aff (Maybe a))
  -> Hook r (Signal (FetchStatus a) /\ (req -> Aff Unit))
useApi aff = do
  valueSig /\ valueAtom <- signal NotFetched

  let
    fetch req = do
      value <- aff req
      liftEffect $ writeAtom valueAtom case value of
        Just a -> Fetched a
        Nothing -> Failed

  pure $ valueSig /\ fetch
