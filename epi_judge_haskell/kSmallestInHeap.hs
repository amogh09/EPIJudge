import           Data.LeftistHeap         (LHeap, children, delMin, fromList,
                                           getMin', insert, isEmpty, singleton)
import           TestFramework.TestRunner

-- This problem has been modified to find k smallest elements in the heap as
-- the current heap implementation provided with the framework only supports
-- minheap.
kSmallestInHeap :: (Ord a) => Int -> LHeap a () -> [a]
kSmallestInHeap k h = []

main = goTest
  (uncurry kSmallestInHeap)
  (\(x:y:_) -> (intData y, fromList . flip zip (repeat ()) . fmap negate . intList $ x))
  (fmap negate . intList . (!! 2))
  (==)
  "../test_data/k_largest_in_heap.tsv"
