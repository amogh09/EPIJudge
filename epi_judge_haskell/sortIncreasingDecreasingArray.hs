import TestFramework.TestRunner 
import qualified Data.LeftistHeap as H

-- A simple implementation of Binary Heap is provided under the module 
-- Data.LeftistHeap. See the module for the API.

sort :: (Ord a) => [a] -> [a]
sort xs = xs -- TODO

main = goTest 
    sort 
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/sort_increasing_decreasing_array.tsv"