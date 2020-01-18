import TestFramework.TestRunner 
import qualified Data.Array as A 

advanceByOffsets :: [Int] -> Bool 
advanceByOffsets xs = True -- TODO
  
main = goTest 
    advanceByOffsets
    (intList . head)
    (boolData . head . tail)
    (==)
    "../test_data/advance_by_offsets.tsv"