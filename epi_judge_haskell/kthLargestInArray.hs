{-# LANGUAGE TupleSections #-}

import           Control.Monad            (foldM)
import           Control.Monad.Primitive  (PrimMonad, PrimState)
import           Control.Monad.ST         (ST, runST)
import qualified Data.Vector              as V
import           Data.Vector.Mutable      (MVector)
import qualified Data.Vector.Mutable      as MV
import           System.Random            (RandomGen, getStdGen, randomR)
import           TestFramework.TestRunner

findKthLargest
  :: (Ord a, PrimMonad m, RandomGen g)
  => g -> Int -> MVector (PrimState m) a -> m (a,g)
findKthLargest g k xs = (,g) <$> MV.read xs 0 -- TODO

findWrapper :: (Ord a, RandomGen g) => Int -> [a] -> g -> (a,g)
findWrapper k xs g = runST $ V.thaw (V.fromList xs) >>= findKthLargest g k

main :: IO ()
main = do
  g <- getStdGen
  goTestRandom
    g
    (uncurry findWrapper)
    (\(x:y:_) -> (intData x, intList y))
    (intData . (!! 2))
    (==)
    "../test_data/kth_largest_in_array.tsv"
