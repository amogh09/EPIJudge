import           Data.Bifunctor
import           TestFramework.TestRunner

findMinMax :: (Ord a) => [a] -> (a,a)
findMinMax [x] = (x,x)
findMinMax xs  = search (xs !! 0, xs !! 1) xs where
  search (lo,hi) []  = (lo,hi)
  search (lo,hi) [x] = (min lo x, max hi x)
  search (lo,hi) (x1:x2:xs) =
    let (l,h) = if x1 <= x2 then (x1,x2) else (x2,x1)
    in  search (min l lo, max h hi) xs

main :: IO ()
main = goTest
  findMinMax
  (intList . head)
  (bimap intData intData . tuple2Data . (!! 1))
  (==)
  "../test_data/search_for_min_max_in_array.tsv"
