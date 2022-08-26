module Utils.ForceWriteAtom
  ( forceModifyAtom
  , forceModifyAtom_
  , forceWriteAtom
  ) where

import Prelude

import Control.Safely (for_)
import Effect (Effect)
import Jelly (Atom)

foreign import data Observer :: Type

foreign import getObservers :: forall a. Atom a -> Effect (Array Observer)
foreign import getAtomValue :: forall a. Atom a -> Effect a
foreign import setAtomValue :: forall a. Atom a -> a -> Effect Unit
foreign import getObserverSignal :: Observer -> Effect (Observer -> Effect Unit)
foreign import getObserverCallbacks :: Observer -> Effect (Array (Effect Unit))
foreign import clearObserverCallbacks :: Observer -> Effect Unit

forceModifyAtom :: forall a. Eq a => Atom a -> (a -> a) -> Effect a
forceModifyAtom atom f = do
  atomValue <- getAtomValue atom

  let
    newAtomValue = f atomValue

  observers <- getObservers atom
  for_ observers \obs -> do
    callbacks <- getObserverCallbacks obs
    clearObserverCallbacks obs
    for_ callbacks identity

  setAtomValue atom newAtomValue

  for_ observers \obs -> do
    s <- getObserverSignal obs
    s obs

  pure newAtomValue

forceModifyAtom_ :: forall a. Eq a => Atom a -> (a -> a) -> Effect Unit
forceModifyAtom_ atom f = forceModifyAtom atom f $> unit

forceWriteAtom :: forall a. Eq a => Atom a -> a -> Effect Unit
forceWriteAtom atom v = forceModifyAtom_ atom $ const v
