import TestFramework.TestRunner

search :: Int -> [Int] -> Int
search x xs = -1 -- TODO

main = goTest 
    (uncurry search)
    (\(x:y:_) -> (intData y, intList x))
    (intData . (!!2))
    (==)
    "../test_data/search_in_list.tsv"