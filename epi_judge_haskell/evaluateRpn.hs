import TestFramework.TestRunner
import Numeric (readDec)

rpn :: [String] -> Int 
rpn ps = 0 -- TODO

fastRead :: String -> Int
fastRead s = case readDec s of [(n, "")] -> n

main = goTest
    rpn 
    (split ',' . stringData . head)
    (intData . head . tail)
    (==)
    "../test_data/evaluate_rpn.tsv"