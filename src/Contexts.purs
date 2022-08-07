module Contexts where

import Contexts.ColorMode (ColorModeContext)
import Contexts.Page (PageContext)

type Contexts = Record (ColorModeContext (PageContext ()))
