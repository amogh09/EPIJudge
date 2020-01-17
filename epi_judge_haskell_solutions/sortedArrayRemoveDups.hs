import TestFramework.TestRunner 

removeDups :: (Eq a) => [a] -> [a]
removeDups [] = []
removeDups [x] = [x]
removeDups (x:x':xs)
    | x == x' = removeDups (x':xs)
    | otherwise = x : removeDups (x':xs)

main :: IO ()
main = goTest 
    removeDups
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/sorted_array_remove_dups.tsv"