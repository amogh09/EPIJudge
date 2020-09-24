import           Data.Vector              (Vector)
import qualified Data.Vector              as V
import           TestFramework.TestRunner

matrixSearch :: (Ord a, Eq a) => a -> Vector (Vector a) -> Bool
matrixSearch x matrix = False

main :: IO ()
main = goTest
  (uncurry matrixSearch)
  (\(x:y:_) -> (intData y, V.fromList . fmap (V.fromList) . listOfIntList $ x))
  (boolData . (!!2))
  (==)
  "../test_data/search_row_col_sorted_matrix.tsv"
