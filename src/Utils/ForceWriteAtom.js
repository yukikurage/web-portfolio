"use strict";

export const getObservers = (atom /* :: Atom a */) => () =>
  [...atom.observers];

export const getAtomValue = (atom /* :: Atom a */) => () => atom.value;

export const setAtomValue =
  (atom /* :: Atom a */) => (value /* a */) => () => {
    atom.value = value;
  };

export const getObserverSignal = (observer /* :: Observer */) => () =>
  observer.signal;

export const getObserverCallbacks = (observer /* :: Observer */) => () =>
  [...observer.callbacks];

export const clearObserverCallbacks = (observer /* :: Observer */) => () => {
  observer.callbacks.clear();
}
