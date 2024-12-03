module Lib (countSafeLines, process, process') where

process :: String -> Int
process contents =
  let list = filter (/= []) (map (map read . words) (lines contents)) in
  countSafeLines list

process' :: String -> Int
process' contents =
  let list = map (map read . words) (lines contents) in 
  let countSafeLines' = length . filter isSafe' in
  countSafeLines' list

isSafe' :: [Int] -> Bool
isSafe' list = any (\x -> isSafe (take x list ++ drop (x+1) list)) [0.. length list - 1]
 

countSafeLines :: [[Int]] -> Int
countSafeLines = length . filter isSafe

isSafe :: [Int] -> Bool
isSafe list = isDecreasing list || isIncreasing list

isDecreasing :: [Int] -> Bool
isDecreasing [] = True
isDecreasing [_] = True
isDecreasing (top:second:rest) = 
  1 <= top - second
  && top - second <= 3 
  && isDecreasing(second:rest)

-- todo
isIncreasing :: [Int] -> Bool
isIncreasing [] = True
isIncreasing [_] = True
isIncreasing (top:second:rest) = 
  top - second <= -1
  && -3 <= top - second
  && isIncreasing(second:rest)
