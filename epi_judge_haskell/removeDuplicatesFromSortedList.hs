import TestFramework.TestRunner 

nubSorted :: (Eq a) => [a] -> [a]
nubSorted xs = xs -- TODO Fill here

main = goTest 
    nubSorted
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/remove_duplicates_from_sorted_list.tsv"