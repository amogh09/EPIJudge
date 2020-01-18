import TestFramework.TestRunner
import Data.Bits 

swapBits :: Integer -> Int -> Int -> Integer
swapBits x i j = x -- TODO

main = goTest
    (uncurry2 swapBits)
    (\(x:y:z:_) -> (longData x, intData y, intData z))
    (\x -> longData (x !! 3))
    (==)
    "../test_data/swap_bits.tsv"