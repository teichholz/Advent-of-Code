{-# LANGUAGE TypeApplications #-}
module Main where
import Data.Char (digitToInt)

readInput :: IO [String]
readInput = lines <$> readFile "input"

transpose :: [[a]] -> [[a]]
transpose ls =
  if null (concat ls) then []
  else heads ls : transpose (tails ls)
  where
    heads = fmap head
    tails = fmap tail

count :: String -> (Int, Int)
count = foldl
  (\(zero, one) c -> if c == '1' then (zero, one+1) else (zero+1, one))
  (0,0)

countToNum :: (Int -> Int -> Int) -> (Int, Int) -> Char
countToNum f (zero, one) = if f zero one == one then '1' else '0'

binToDec :: [Char] -> Int
binToDec = foldl (\acc e -> 2 * acc + digitToInt e) 0

part1 :: [String] -> Int
part1 nums =
  let nums' = transpose nums
      ts = count <$> nums' in
    binToDec (fmap (countToNum max) ts)
    * binToDec (fmap (countToNum min) ts)
