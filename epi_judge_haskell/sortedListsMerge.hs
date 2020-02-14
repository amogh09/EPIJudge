import TestFramework.TestRunner 

merge :: (Ord a) => [a] -> [a] -> [a]
merge xs ys = xs -- TODO

main = goTest 
    (uncurry merge)
    (\(x:y:_) -> (intList x, intList y))
    (intList . (!!2))
    (==)
    "../test_data/sorted_lists_merge.tsv"