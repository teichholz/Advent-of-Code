{-# LANGUAGE TypeApplications #-}
module Main where

import Control.Monad.State.Lazy
import Data.Bifunctor

main :: IO ()
main = do
  inp <- readInput
  let (hor, dpth) = execState (mapM_ interpreter inp) (0, 0)
  print $ hor * dpth
  let (hor', dpth', _) = execState (mapM_ interpreter' inp) (0, 0, 0)
  print $ hor' * dpth'

interpreter :: (String, Int)-> State (Int, Int) ()
interpreter ("forward", x) = modify (first (+x))
interpreter ("up", x) = modify (second (\a -> a - x))
interpreter ("down", x) = modify (second (+x))

interpreter' :: (String, Int)-> State (Int, Int, Int) ()
interpreter' ("forward", x) = do
  (h,d,a) <- get
  put (h+x,d + a*x,a)
interpreter' ("up", x) = do
  (h,d,a) <- get
  put (h,d,a-x)
interpreter' ("down", x) = do
  (h,d,a) <- get
  put (h,d,a+x)

readInput :: IO [(String, Int)]
readInput = pair . words <$> readFile "input"
  where
    pair [] = []
    pair (fst:snd:tl) = (fst, read @Int snd):pair tl
