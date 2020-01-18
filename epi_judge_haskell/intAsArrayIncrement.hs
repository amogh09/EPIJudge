import TestFramework.TestRunner 

increment :: [Int] -> [Int]
increment xs = xs -- TODO

main = goTest 
    increment 
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/int_as_array_increment.tsv"