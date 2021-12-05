{-# LANGUAGE LambdaCase #-}
module Main where

import Control.Applicative (liftA2)
import Data.List (sort, group, sortBy)
import Data.Function (on)

main :: IO ()
main = do
  inp <- readInput
  print $ part1 inp
  print $ part2 inp

type Point = (Int, Int)
type Range = (Point, Point)

part1 :: [Range] -> Int
part1 = dangerousLines (>=2) . rangesToPoints horOrVer rangeToPoints

part2 :: [Range] -> Int
part2 =  dangerousLines (>=2)
         . liftA2
             (++)
             (rangesToPoints diag rangeToPoints)
             (rangesToPoints horOrVer rangeToPoints)

dangerousLines :: (Int -> Bool) -> [Point] -> Int
dangerousLines pred = length . filter pred . fmap length . group . sort

rangesToPoints :: (Range -> Bool) -> (Range -> [Point]) -> [Range] -> [Point]
rangesToPoints pred rangeToPoints = concatMap rangeToPoints . filter pred

rangeToPoints :: Range -> [Point]
rangeToPoints r@((x1, y1), (x2, y2)) =
  let fx = (+ signum (x2 - x1))
      fy = (+ signum (y2 - y1)) in
    take (distance' r) $ zip (iterate fx x1) (iterate fy y1)

horOrVer :: Range -> Bool
horOrVer ((x1, y1), (x2, y2)) = x1 == x2 || y1 == y2

diag :: Range -> Bool
diag ((x1, y1), (x2, y2)) = distance x1 x2 == distance y1 y2

distance :: Int -> Int -> Int
distance i1 i2 = max i1 i2 - min i1 i2 + 1

distance' :: Range -> Int
distance' ((x1, y1), (x2, y2)) = max (distance x1 x2) (distance y1 y2)

readInput :: IO [Range]
readInput = do
  inp <- (fmap . fmap) words $ lines . fmap commaToSpace <$> readFile "input"
  return $ parse <$> inp
  where
    parse :: [String] -> Range
    parse [x1, y1, _, x2, y2] = ((read x1, read y1), (read x2, read y2))
    commaToSpace = \case
      ',' -> ' '
      x -> x
