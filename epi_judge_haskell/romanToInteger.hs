import TestFramework.TestRunner 
import Data.Text (unpack)

romanToInteger :: String -> Int 
romanToInteger xs = 0 

main = goTest 
    romanToInteger
    (unpack . textData . head)
    (intData . head . tail)
    (==)
    "../test_data/roman_to_integer.tsv"