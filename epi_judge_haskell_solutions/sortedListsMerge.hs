import TestFramework.TestRunner 

merge :: (Ord a) => [a] -> [a] -> [a]
merge [] ys = ys 
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

main = goTest 
    (uncurry merge)
    (\(x:y:_) -> (intList x, intList y))
    (intList . (!!2))
    (==)
    "../test_data/sorted_lists_merge.tsv"