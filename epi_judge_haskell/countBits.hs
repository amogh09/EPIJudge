import TestFramework.TestRunner
import Data.Bits

countBits :: Int -> Int
countBits x = x -- TODO

main = goTest 
    countBits 
    (intData . head) 
    (intData . head . tail)
    (==) 
    "../test_data/count_bits.tsv"