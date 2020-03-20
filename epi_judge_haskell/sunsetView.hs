import TestFramework.TestRunner 

sunset :: [Int] -> [Int]
sunset xs = [] -- TODO

main = goTest 
    sunset
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/sunset_view.tsv"