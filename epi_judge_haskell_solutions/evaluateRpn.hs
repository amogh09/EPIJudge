import TestFramework.TestRunner
import Numeric (readDec)

rpn :: [String] -> Int 
rpn = f [] where 
    f (x:x':xs) ("+":ps) = f ((x' + x):xs) ps
    f (x:x':xs) ("-":ps) = f ((x' - x):xs) ps
    f (x:x':xs) ("*":ps) = f ((x' * x):xs) ps 
    f (x:x':xs) ("/":ps) = f ((x' `div` x):xs) ps 
    f xs (p:ps) = f (fastRead p:xs) ps 
    f [x] [] = x

fastRead :: String -> Int
fastRead s = case readDec s of [(n, "")] -> n

main = goTest
    rpn 
    (split ',' . stringData . head)
    (intData . head . tail)
    (==)
    "../test_data/evaluate_rpn.tsv"