module Ansi
  ( IsColor(..)
  , colorSeq
  , withBackground
  , withForeground
  , withBackFore
  , sample
  ) where

import           Data.List

class IsColor a where
  setForeground :: a -> String
  setBackground :: a -> String

esc :: String
esc = "\x1b["

colorSeq :: [Int] -> String
colorSeq params = esc ++ intercalate ";" (map show params) ++ "m"

reset :: String
reset = colorSeq [0]

withBackground :: IsColor b => b -> String -> String
withBackground b s = setBackground b ++ s ++ reset

withForeground :: IsColor f => f -> String -> String
withForeground f s = setForeground f ++ s ++ reset

withBackFore :: (IsColor b, IsColor f) => b -> f -> String -> String
withBackFore b f s = setBackground b ++ setForeground f ++ s ++ reset

sample :: IsColor a => a -> String
sample c = withBackground c "background" ++ " " ++ withForeground c "foreground"
