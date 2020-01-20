import TestFramework.TestRunner 

applyPerm :: [Int] -> [a] -> [a] 
applyPerm ps xs = xs -- TODO 

main = goTest
    (uncurry applyPerm)
    (\(x:y:_) -> (intList x, intList y))
    (intList . head . drop 2)
    (==)
    "../test_data/apply_permutation.tsv"