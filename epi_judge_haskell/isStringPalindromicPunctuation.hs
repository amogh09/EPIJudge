import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.Char (toLower,isAlphaNum)

isPalindromic :: String -> Bool 
isPalindromic xs = False -- TODO

main = goTest 
    isPalindromic
    (unpack . textData . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_string_palindromic_punctuation.tsv"