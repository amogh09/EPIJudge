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
findKthLargest g k xs = findKthSmallest g (n-k+1) xs where
  n = MV.length xs

findKthSmallest
  :: (Ord a, PrimMonad m, RandomGen g)
  => g -> Int -> MVector (PrimState m) a -> m (a,g)
findKthSmallest g k xs = do
  let (pvi,g') = randomR (0,n-1) g
  MV.swap xs pvi (n-1)
  pv <- xs `MV.read` (n-1)
  i  <- (subtract 1) <$> rearrange pv
  case i `compare` (k-1)of
    LT -> findKthSmallest g' (k-i-1) $ MV.drop (i+1) xs
    EQ -> (,) <$> MV.read xs i <*> pure g'
    GT -> findKthSmallest g' k $ MV.take i xs
  where
    n = MV.length xs
    rearrange pv = foldM (f pv) 0 [0..n-1]
    f pv i j = do
      x <- MV.read xs j
      case x `compare` pv of
        GT -> return i
        _  -> MV.swap xs i j >> return (i+1)

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
