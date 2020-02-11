import TestFramework.TestRunner

insert :: [a] -> Int -> a -> [a]
insert xs 0 x = x:xs
insert [] _ x = [x]
insert (x':xs) i x = x' : insert xs (i-1) x

main = goTest 
    (uncurry2 insert)
    (\(x:y:z:_) -> (intList x, intData y, intData z))
    (intList . (!!3))
    (==)
    "../test_data/insert_in_list.tsv"