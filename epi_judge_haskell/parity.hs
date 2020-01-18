import TestFramework.TestRunner 
import Data.Bits

parity :: Integer -> Int
parity x = 0 -- TODO

main = goTest 
    parity 
    (longData . head) 
    (intData . head . tail)
    (==) 
    "../test_data/parity.tsv"