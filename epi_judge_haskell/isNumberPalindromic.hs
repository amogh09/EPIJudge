import TestFramework.TestRunner 

isNumberPalindromic :: Int -> Bool 
isNumberPalindromic x = True -- TODO 

main = goTest 
    isNumberPalindromic
    (intData . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_number_palindromic.tsv"