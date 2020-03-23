import TestFramework.TestRunner 
import qualified TestFramework.LeftistHeap as H

-- A simple implementation of Binary Heap is provided under the module 
-- TestFramework.LeftistHeap. See the module for the API.

mergeLists :: (Ord a) => [[a]] -> [a]
mergeLists = head -- TODO

main = goTest 
    mergeLists 
    (listOfIntList . head)
    (intList . head . tail)
    (==)
    "../test_data/sorted_arrays_merge.tsv"