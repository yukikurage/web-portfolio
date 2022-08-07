module Contexts.Page where

import Prelude

import Data.Pages (Page(..), hashToPage, pageToHash)
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Jelly (Atom, Hook, Signal, launch_, signal, useContext, writeAtom)
import Routing.Hash (getHash, setHash)
import Web.Event.EventTarget (addEventListener, eventListener)
import Web.HTML (window)
import Web.HTML.Event.HashChangeEvent.EventTypes (hashchange)
import Web.HTML.Window (toEventTarget)

type PageContext r =
  ( page :: Signal Page /\ Atom Page
  | r
  )

usePage
  :: forall r
   . Hook (Record (PageContext r))
       (Signal Page /\ Atom Page)
usePage = do
  { page } <- useContext
  pure page

providePage
  :: Effect (Signal Page /\ Atom Page)
providePage = do
  initialHash <- getHash

  pageSig /\ pageAtom <- signal $ hashToPage initialHash

  -- Page が変わったときに Hash を書き換える (PageNotFound は例外)
  launch_ do
    page <- pageSig
    liftEffect $ setHash $ pageToHash page

  -- Hash が変わった時に Page を書き換える
  listener <- eventListener \_ -> do
    hash <- getHash
    writeAtom pageAtom $ hashToPage hash

  addEventListener hashchange listener false <<< toEventTarget =<< window

  pure $ pageSig /\ pageAtom
