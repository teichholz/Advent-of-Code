{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeApplications #-}
module Main where
import Data.List (transpose)
import Data.Maybe (listToMaybe, mapMaybe)
import Control.Applicative (liftA2)

main :: IO ()
main = do
  inp <- readInput
  print $ part1 inp

part1 :: ([Int], [[[Int]]]) -> Int
part1 (pick:picks, boards) =
  let marked = fmap (markBoard pick) boards
      winner = maybeGetWinner marked in
    case winner of
      Just board -> pick * sumAllUnmarked board
      Nothing -> part1 (picks, marked)

rowIsMarked :: [Int] -> Bool
rowIsMarked = (== 0) . sum

markRow :: Int -> [Int] -> [Int]
markRow i = fmap (\i' -> if i == i' then 0 else i')

markBoard :: Int -> [[Int]] -> [[Int]]
markBoard i  = fmap (markRow i)

maybeBoardIsWinner :: [[Int]] -> Maybe [[Int]]
maybeBoardIsWinner board =
  let won = or . fmap rowIsMarked in
  if liftA2 (||) won (won . transpose) board
  then Just board
  else Nothing

maybeGetWinner :: [[[Int]]] -> Maybe [[Int]]
maybeGetWinner = listToMaybe . mapMaybe maybeBoardIsWinner

sumAllUnmarked :: [[Int]] -> Int
sumAllUnmarked = sum . fmap sum

readInput :: IO ([Int], [[[Int]]])
readInput = do
  inp <- filter (not . null) . lines <$> readFile "input"
  let picks = fmap (zero2minus1 . read @Int) $ words $ map comma2space $ head inp
      boards =  groupRows $ fmap (zero2minus1 . read @Int) . words <$> tail inp
  return (picks, boards)
  where
    zero2minus1 = \case
      0 -> -1
      x -> x
    comma2space = \case
      ',' -> ' '
      x -> x
    groupRows [] = []
    groupRows (r1:r2:r3:r4:r5:tl) = [r1,r2,r3,r4,r5]:groupRows tl
