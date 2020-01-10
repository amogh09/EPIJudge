import TestRunner 
import Data.Bits 

getBit :: Int -> Int -> Int
getBit i x = (x `shiftR` i) .&. 1

primitiveDivide :: Int -> Int -> Int 
primitiveDivide x y = f 0 31 0 where 
    f _ (-1) q = q
    f z i q = 
        let z' = (z `shiftL` 1) .|. (getBit i x)
        in  if z' >= y 
                then f (z' - y) (i-1) ((q `shiftL` 1) .|. 1)
                else f z' (i-1) (q `shiftL` 1)

main = goTest 
    (uncurry primitiveDivide)
    (\(x:y:_)   -> (intData x, intData y))
    (\(_:_:z:_) -> intData z)
    "../test_data/primitive_divide.tsv"