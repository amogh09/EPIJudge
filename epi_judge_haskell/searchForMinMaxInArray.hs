import           Data.Bifunctor
import           TestFramework.TestRunner

findMinMax :: (Ord a) => [a] -> (a,a)
findMinMax xs = (head xs, head xs) -- TODO

main :: IO ()
main = goTest
  findMinMax
  (intList . head)
  (bimap intData intData . tuple2Data . (!! 1))
  (==)
  "../test_data/search_for_min_max_in_array.tsv"
