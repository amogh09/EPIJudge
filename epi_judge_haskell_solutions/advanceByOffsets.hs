import TestFramework.TestRunner 
import qualified Data.Array as A 

advanceByOffsets :: [Int] -> Bool 
advanceByOffsets xs = f 0 ([0..] `zip` xs) >= (n-1) where 
    n = length xs 
    f r [] = r 
    f r ((i,x):xs) 
        | i <= r = f (max r (i+x)) xs 
        | otherwise = r
  
main = goTest 
    advanceByOffsets
    (intList . head)
    (boolData . head . tail)
    (==)
    "../test_data/advance_by_offsets.tsv"