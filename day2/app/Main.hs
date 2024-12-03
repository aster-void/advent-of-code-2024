module Main (main) where

import qualified System.Environment as SE
import Lib(process, process')

main :: IO ()
main = do
  args <- SE.getArgs
  contents <- readFile (args !! 1)
  let result = if head args == "1" then process contents else process' contents
  print result
