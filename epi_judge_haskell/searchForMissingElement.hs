import           Data.Bifunctor           (bimap)
import           Data.Bits
import           Data.List
import           TestFramework.TestRunner

findDuplicateMissing :: [Int] -> (Int,Int)
findDuplicateMissing xs = (0,0) -- TODO

main = goTest
  findDuplicateMissing
  (intList . head)
  (bimap intData intData . tuple2Data . (!!1))
  (==)
  "../test_data/find_missing_and_duplicate.tsv"
