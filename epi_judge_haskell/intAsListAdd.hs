import TestFramework.TestRunner 

add :: [Int] -> [Int] -> [Int]
add xs ys = xs -- TODO

main = goTest 
    (uncurry add)
    (\(x:y:_) -> (intList x, intList y))
    (intList . (!!2))
    (==)
    "../test_data/int_as_list_add.tsv"