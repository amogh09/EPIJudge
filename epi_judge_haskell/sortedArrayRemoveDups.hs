import TestFramework.TestRunner 

removeDups :: (Eq a) => [a] -> [a]
removeDups xs = xs -- TODO

main :: IO ()
main = goTest 
    removeDups
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/sorted_array_remove_dups.tsv"