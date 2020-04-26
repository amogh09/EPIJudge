import TestFramework.TestRunner 

sqroot :: Int -> Int 
sqroot x = x

main = goTest 
    sqroot
    (intData . head)
    (intData . head . tail)
    (==)
    "../test_data/int_square_root.tsv"