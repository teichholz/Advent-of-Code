module Main where

import Prelude hiding (cycle, repeat)
import Data.List.Split (splitOn)
import Data.List (sort, group)

part1 :: [Int] -> Int
part1 = population . repeat 80 cycle . buildStartList

part2 :: [Int] -> Int
part2 = population . repeat 256 cycle . buildStartList

buildStartList :: [Int] -> [Int]
buildStartList fishAges = do
  age <- [0..8]
  return $ length $ filter (==age) fishAges

cycle :: [Int] -> [Int]
cycle (zr:on:tw:th:fo:fv:sx:sn:ei:[]) = on:tw:th:fo:fv:sx:(sn+zr):ei:[zr]

repeat :: Int -> (a -> a) -> (a -> a)
repeat 0 f = id
repeat n f = repeat (n-1) f . f

population :: [Int] -> Int
population = sum

readInput :: IO [Int]
readInput = fmap read . splitOn "," . head . lines <$> readFile "input"
