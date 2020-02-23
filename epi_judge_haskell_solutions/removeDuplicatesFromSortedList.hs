import TestFramework.TestRunner 

nubSorted :: (Eq a) => [a] -> [a]
nubSorted []  = []
nubSorted [x] = [x]
nubSorted (x:x':xs)
    | x == x'   = nubSorted (x':xs) 
    | otherwise = x : nubSorted (x':xs)

main = goTest 
    nubSorted
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/remove_duplicates_from_sorted_list.tsv"