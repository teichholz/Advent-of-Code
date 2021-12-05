module Main where

import Lib

main :: IO ()
main = do
  return ()

increased :: [Int] -> Int
increased nums =
  let ones = zipWith (\i i' -> if i' > i then 1 else 0) nums (tail nums) in
  foldl1 (+) ones

increased' :: [Int] -> Int
increased' nums =
  let windows = zipWith3 (\i i' i'' -> [i, i', i'']) nums (tail nums) (tail $ tail nums) in
  increased $ fmap (foldl1 (+)) windows


readNums :: IO [Int]
readNums = do
  input <- readFile "input"
  return $ map read $ words input
