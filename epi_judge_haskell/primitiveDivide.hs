import TestFramework.TestRunner 
import Data.Bits 

primitiveDivide :: Int -> Int -> Int 
primitiveDivide x y = 0 -- TODO

main = goTest 
    (uncurry primitiveDivide)
    (\(x:y:_)   -> (intData x, intData y))
    (\(_:_:z:_) -> intData z)
    (==)
    "../test_data/primitive_divide.tsv"