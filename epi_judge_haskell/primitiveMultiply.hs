import TestFramework.TestRunner 
import Data.Bits 

primitiveMultiply :: Integer -> Integer -> Integer 
primitiveMultiply x y = x -- TODO

main = goTest 
    (uncurry primitiveMultiply)
    (\(x:y:_)   -> (longData x, longData y))
    (\(_:_:z:_) -> longData z)
    (==)
    "../test_data/primitive_multiply.tsv"