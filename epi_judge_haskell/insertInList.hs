import TestFramework.TestRunner

insert :: [a] -> Int -> a -> [a]
insert xs i x = xs -- TODO

main = goTest 
    (uncurry2 insert)
    (\(x:y:z:_) -> (intList x, intData y, intData z))
    (intList . (!!3))
    (==)
    "../test_data/insert_in_list.tsv"