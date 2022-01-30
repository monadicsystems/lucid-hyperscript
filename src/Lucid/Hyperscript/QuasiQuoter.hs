{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}

module Lucid.Hyperscript.QuasiQuoter (_hs, __) where

import Data.Text (Text(..))
import qualified Data.Text as Text
import GHC.Exts (IsString (..))
import qualified Language.Haskell.TH as TH
import Language.Haskell.TH.Quote ( QuasiQuoter(QuasiQuoter) )
import Lucid (script_, toHtml, type_)
import Lucid.Base (makeAttribute)

__ :: QuasiQuoter
__ =
  QuasiQuoter
    ((\text -> [|makeAttribute "_" text|]) . processString)
    (error "Cannot use __ as a pattern")
    (error "Cannot use __ as a type")
    (error "Cannot use __ as a dec")

_hs :: QuasiQuoter
_hs =
  QuasiQuoter
    ((\text -> [|script_ [type_ "text/hyperscript"] $ toHtml text|]) . processString)
    (error "Cannot use _hs as a pattern")
    (error "Cannot use _hs as a type")
    (error "Cannot use _hs as a dec")

processString :: String -> Text
processString = Text.strip . removeCRs . Text.pack
  where
    removeCRs = Text.filter (/= '\r')
