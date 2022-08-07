module Hooks.UseLink where

import Prelude

import Data.Page (Page, pageToHash)
import Jelly (Hook, Signal, (:=))

useLink :: forall r. Signal Page -> Hook r Unit
useLink pageSig = do
  "href" := do
    page <- pageSig
    pure $ "#" <> pageToHash page
