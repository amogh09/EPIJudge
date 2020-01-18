import TestFramework.TestRunner
import Data.Bits

reverseBits :: Integer -> Integer
reverseBits x = x -- TODO

main = goTest 
    reverseBits 
    (longData . head) 
    (longData . head . tail) 
    (==)
    "../test_data/reverse_bits.tsv"