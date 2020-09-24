import           Data.Vector              (Vector)
import qualified Data.Vector              as V
import           TestFramework.TestRunner

matrixSearch :: (Ord a, Eq a) => a -> Vector (Vector a) -> Bool
matrixSearch x matrix = search 0 (n - 1) where
  search i j | i >= m || j >= n || i < 0 || j < 0 = False
  search i j | matrix V.! i V.! j == x = True
  search i j | matrix V.! i V.! j < x = search (i+1) j
  search i j = search i (j-1)

  m = V.length matrix
  n = V.length $ matrix V.! 0

main :: IO ()
main = goTest
  (uncurry matrixSearch)
  (\(x:y:_) -> (intData y, V.fromList . fmap (V.fromList) . listOfIntList $ x))
  (boolData . (!!2))
  (==)
  "../test_data/search_row_col_sorted_matrix.tsv"
