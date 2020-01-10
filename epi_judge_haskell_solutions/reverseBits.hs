import TestRunner
import Data.Bits

swapBits :: Integer -> Int -> Int -> Integer
swapBits x i j = 
    let x' = setBit i (getBit j x) x
    in  setBit j (getBit i x) x'
    where
        setBit i 1 y = y .|. (1 `shiftL` i)
        setBit i 0 y = y .&. (complement (1 `shiftL` i))
        getBit i y = (y `shiftR` i) .&. 1

reverseBits :: Integer -> Integer
reverseBits = f 0 63 where 
    f i j x
        | i < j = f (i+1) (j-1) (swapBits x i j)
        | otherwise = x 

main = goTest 
    reverseBits 
    (longData . head) 
    (longData . head . tail) 
    "../test_data/reverse_bits.tsv"