module Pages.Posts where

import Prelude

import Api.Posts (getPosts)
import Components.PageTitle (pageTitleComponent)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Data.Functor (mapFlipped)
import Data.Int (floor)
import Data.JSDate (JSDate)
import Data.JSDate as JSDate
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, ch, chSig, chs, el, text)

postsPageComponent :: Component Contexts
postsPageComponent = el "div" do
  postsStatusSig /\ fetchWorks <- useApi $ \_ -> getPosts
  liftEffect $ launchAff_ $ fetchWorks unit

  useClass $ pure "w-full"
  useClass $ pure "flex flex-col p-10 gap-28 items-center"

  ch $ pageTitleComponent $ pure "Blog"

  chSig do
    postsStatus <- postsStatusSig
    pure case postsStatus of
      Fetched posts -> el "div" do
        useClass $ pure "w-full md:w-3/4"
        useClass $ pure
          "flex flex-col gap-4"
        usePopIn
        chs $ mapFlipped posts \post -> el "div" do
          useColor Primary Background

          useClass $ pure
            "relative w-full overflow-hidden rounded shadow-md group p-4 cursor-pointer hover:opacity-80 transition-opacity"

          useClass $ pure
            "flex flex-col gap-2 items-start"

          ch $ el "div" do
            useClass $ pure "text-sm"

            dateText <- liftEffect $ getDateText post.publishedAt

            ch $ text $ pure $ dateText

          ch $ el "div" do
            useClass $ pure "flex gap-2 items-baseline"

            ch $ el "div" do
              useClass $ pure "text-2xl font-bold pl-1"

              ch $ text $ pure post.title

            ch $ el "div" do
              useClass $ pure "flex flex-row gap-2 opacity-90 flex-wrap pl-1"
              chs $ mapFlipped post.tags \tag -> el "p" do
                useClass $ pure "text-sm"

                ch $ text $ pure $ "#" <> tag

          ch $ el "div" do
            useClass $ pure "truncate w-full p-3 opacity-60"

            ch $ text $ pure post.content

      _ -> el "div" $ pure unit

getDateText :: JSDate -> Effect String
getDateText jsDate = do
  year <- floor <$> JSDate.getFullYear jsDate
  month <- floor <$> JSDate.getMonth jsDate
  date <- floor <$> JSDate.getDate jsDate
  pure $ show year <> "/" <> show (month + 1) <> "/" <> show date
