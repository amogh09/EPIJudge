import           Data.LeftistHeap         (delMin, fromList, getMin, insert,
                                           toList)
import           Data.Maybe               (fromJust)
import           TestFramework.TestRunner

sortAlmostSorted :: (Ord a) => Int -> [a] -> [a]
sortAlmostSorted k xs =
  work (fromList . flip zip (repeat ()) . take k $ xs) (drop k xs)
  where
  work heap []     = fst <$> toList heap
  work heap (q:qs) = let h' = insert q () heap
                     in (fst . fromJust . getMin $ h') : work (delMin h') qs

main :: IO ()
main = goTest
  (uncurry sortAlmostSorted)
  (\(x:y:_) -> (intData y, intList x))
  (intList . (!!2))
  (==)
  "../test_data/sort_almost_sorted_array.tsv"
