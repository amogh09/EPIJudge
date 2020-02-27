import TestFramework.TestRunner 

isPalindromic :: (Eq a) => [a] -> Bool 
isPalindromic xs = False -- TODO

main = goTest 
    isPalindromic
    (intList . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_list_palindromic.tsv"