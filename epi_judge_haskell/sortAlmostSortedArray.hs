import           Data.LeftistHeap         (delMin, fromList, getMin, insert,
                                           toList)
import           Data.Maybe               (fromJust)
import           TestFramework.TestRunner

sortAlmostSorted :: (Ord a) => Int -> [a] -> [a]
sortAlmostSorted k xs = xs

main :: IO ()
main = goTest
  (uncurry sortAlmostSorted)
  (\(x:y:_) -> (intData y, intList x))
  (intList . (!!2))
  (==)
  "../test_data/sort_almost_sorted_array.tsv"
