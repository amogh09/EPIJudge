import           Data.LeftistHeap         (LHeap, children, delMin, fromList,
                                           getMin', insert, isEmpty, singleton)
import           TestFramework.TestRunner

-- This problem has been modified to find k smallest elements in the heap as
-- the current heap implementation provided with the framework only supports
-- minheap.
kSmallestInHeap :: (Ord a) => Int -> LHeap a () -> [a]
kSmallestInHeap k h = work k (singleton (fst . getMin' $ h) h) where
  work 0 _ = []
  work i h =
    let
      (x,origHeap) = getMin' h
      (l,r)        = children origHeap
    in
      x : work (i-1) (foldr f (delMin h) . filter (not . isEmpty) $ [l,r])

  f childHeap = insert (fst . getMin' $ childHeap) childHeap

main :: IO ()
main = goTest
  (uncurry kSmallestInHeap)
  (\(x:y:_) -> (intData y, fromList . flip zip (repeat ()) . fmap negate . intList $ x))
  (fmap negate . intList . (!! 2))
  (==)
  "../test_data/k_largest_in_heap.tsv"
