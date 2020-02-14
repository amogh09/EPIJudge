import TestFramework.TestRunner 

delete :: Int -> [a] -> [a]
delete i = f 0 where 
    f _ [] = []
    f j (x:xs)
        | i == j = xs 
        | otherwise = x : f (j+1) xs

main = goTest 
    (uncurry delete)
    (\(x:y:_) -> (intData y, intList x))
    (intList . (!!2))
    (==)
    "../test_data/delete_from_list.tsv"