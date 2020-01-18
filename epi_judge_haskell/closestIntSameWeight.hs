import TestFramework.TestRunner 
import Data.Bits 

closestIntSameWeight :: Integer -> Integer
closestIntSameWeight x = x -- TODO 

main = goTest 
    closestIntSameWeight
    (longData . head)
    (longData . head . tail)
    (==)
    "../test_data/closest_int_same_weight.tsv"