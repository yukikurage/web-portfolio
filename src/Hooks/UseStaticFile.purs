module Hooks.UseStaticFile where

import Prelude

import Affjax.ResponseFormat as RF
import Affjax.Web (get, printError)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Jelly (Hook, Signal, signal, useSignal, writeAtom)

useStaticFile :: forall r. Signal String -> Hook r (Signal (Maybe String))
useStaticFile filePathSig = do
  responseSig /\ responseAtom <- signal Nothing

  useSignal do
    filePath <- filePathSig
    liftEffect $ launchAff_ do
      resEither <- get (RF.String identity) filePath
      case resEither of
        Left err -> log $ printError err
        Right res -> liftEffect $ writeAtom responseAtom $ Just res.body

  pure responseSig
