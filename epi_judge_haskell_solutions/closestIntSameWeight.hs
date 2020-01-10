import TestRunner 
import Data.Bits 

closestIntSameWeight :: Integer -> Integer
closestIntSameWeight = f 0 where
    f 63 x = x 
    f i x
        | getBit (i+1) x /= getBit i x =
            let x' = putBit i (getBit (i+1) x) x 
            in  putBit (i+1) (getBit i x) x'
        | otherwise = f (i+1) x
    getBit i x = x `shiftR` i .&. 1
    putBit i 0 x = clearBit x i  
    putBit i 1 x = setBit x i 

main = goTest 
    closestIntSameWeight
    (longData . head)
    (longData . head . tail)
    "../test_data/closest_int_same_weight.tsv"