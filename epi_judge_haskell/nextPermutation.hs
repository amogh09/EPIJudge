import TestFramework.TestRunner 

nextPerm :: [Int] -> [Int]
nextPerm xs = xs -- TODO 

main = goTest 
    nextPerm
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/next_permutation.tsv"