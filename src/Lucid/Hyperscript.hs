{-# LANGUAGE OverloadedStrings #-}

module Lucid.Hyperscript (useHyperscript, useHyperscriptVersion, _hs, __) where

import Data.Text ( pack, Text )
import Lucid (Html, HtmlT, script_, src_)
import Lucid.Base (Attribute, makeAttribute)
import Lucid.Hyperscript.QuasiQuoter (__, _hs)

useHyperscript :: Monad m => HtmlT m ()
useHyperscript = script_ [src_ "https://unpkg.com/hyperscript.org"] ("" :: Html ())

useHyperscriptVersion :: Monad m => (Int, Int, Int) -> HtmlT m ()
useHyperscriptVersion (major, minor, patch) = script_ [src_ url] ("" :: Html ())
  where
    url :: Text
    url =
      "https://unpkg.com/hyperscript.org@"
        <> showT major
        <> "."
        <> showT minor
        <> "."
        <> showT patch

    showT :: Show a => a -> Text
    showT = pack . show
