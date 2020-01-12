import TestFramework.TestRunner 
import Data.Bits 

mulSingle :: Int -> Int -> Int 
mulSingle 0 0 = 0 
mulSingle 0 1 = 0
mulSingle 1 0 = 0
mulSingle 1 1 = 1 

addSingle :: Int -> Int -> Int -> (Int, Int) 
addSingle 0 0 0 = (0,0)
addSingle 0 0 1 = (0,1)
addSingle 0 1 0 = (0,1)
addSingle 0 1 1 = (1,0)
addSingle 1 0 0 = (0,1)
addSingle 1 0 1 = (1,0)
addSingle 1 1 0 = (1,0)
addSingle 1 1 1 = (1,1)

getBit :: Int -> Integer -> Int
getBit i x = fromIntegral $ (x `shiftR` i) .&. 1

putBit :: Int -> Int -> Integer -> Integer 
putBit i 0 x = clearBit x i 
putBit i 1 x = setBit x i 

add :: Integer -> Integer -> Integer
add x y = f 0 0 0 where 
    f _ 64 r = r 
    f c i  r = let (c',s) = addSingle c (getBit i x) (getBit i y)
               in  f c' (i+1) (putBit i s r)

primitiveMultiply :: Integer -> Integer -> Integer 
primitiveMultiply = f 0 where 
    f i x 0 = 0 
    f i x y 
        | y .&. 1 == 1 = (x `shiftL` i) `add` (f (i+1) x (y `shiftR` 1))
        | otherwise    = f (i+1) x (y `shiftR` 1)

main = goTest 
    (uncurry primitiveMultiply)
    (\(x:y:_)   -> (longData x, longData y))
    (\(_:_:z:_) -> longData z)
    (==)
    "../test_data/primitive_multiply.tsv"