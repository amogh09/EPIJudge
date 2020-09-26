import           Data.Bits
import           TestFramework.TestRunner

findMissingElement :: [Int] -> Int
findMissingElement xs = 0 -- TODO

main = goTest
  findMissingElement
  (intList . head)
  (intData . (!! 1))
  (==)
  "../test_data/absent_value_array.tsv"
