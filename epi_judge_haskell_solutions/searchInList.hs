import TestFramework.TestRunner

search :: Int -> [Int] -> Int
search _ [] = -1
search x' (x:xs) 
    | x == x' = x  
    | otherwise = search x' xs

main = goTest 
    (uncurry search)
    (\(x:y:_) -> (intData y, intList x))
    (intData . (!!2))
    (==)
    "../test_data/search_in_list.tsv"