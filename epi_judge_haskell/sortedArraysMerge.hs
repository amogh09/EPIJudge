import TestFramework.TestRunner 
import qualified Data.LeftistHeap as H

-- A simple implementation of Binary Heap is provided under the module 
-- Data.LeftistHeap. See the module for the API.

mergeLists :: (Ord a) => [[a]] -> [a]
mergeLists = head -- TODO

main = goTest 
    mergeLists 
    (listOfIntList . head)
    (intList . head . tail)
    (==)
    "../test_data/sorted_arrays_merge.tsv"