module Pages.Posts where

import Prelude

import Components.PageTitle (pageTitleComponent)
import Contentful (getPosts)
import Contexts (Contexts)
import Contexts.ColorMode (ColorScheme(..), ColorTarget(..), useColor)
import Contexts.Page (usePage)
import Data.Functor (mapFlipped)
import Data.JSDate (parse)
import Data.Maybe (Maybe(..))
import Data.Page (Page(..))
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Hooks.UseApi (FetchStatus(..), useApi)
import Hooks.UseClass (useClass)
import Hooks.UsePopIn (usePopIn)
import Jelly (Component, ch, chSig, chs, el, on, text, writeAtom)
import Utils.GetDateText (getDateText)

postsPageComponent :: Component Contexts
postsPageComponent = el "div" do
  postsStatusSig /\ fetchWorks <- useApi $ \_ -> Just <$> getPosts
  liftEffect $ launchAff_ $ fetchWorks unit
  _ /\ pageAtom <- usePage

  useClass $ pure "w-full"
  useClass $ pure "flex flex-col py-10 px-4 gap-12 items-center"

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

          on "click" \_ -> writeAtom pageAtom $ PagePostInfo post.id

          useClass $ pure
            "relative w-full overflow-hidden rounded shadow group p-4 cursor-pointer hover:opacity-80 transition-opacity"

          useClass $ pure
            "flex flex-col gap-2 items-start"

          ch $ el "div" do
            useClass $ pure "text-sm"

            dateText <- liftEffect $ getDateText =<< parse post.createdAt

            ch $ text $ pure $ dateText

          ch $ el "div" do
            useClass $ pure "flex flex-col gap-2 items-baseline"

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
