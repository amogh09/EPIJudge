import TestFramework.TestRunner 
import Data.Text (unpack)

romanToInteger :: String -> Int 
romanToInteger []           = 0
romanToInteger ('I':'V':xs) = 4 + romanToInteger xs
romanToInteger ('I':'X':xs) = 9 + romanToInteger xs
romanToInteger ('X':'L':xs) = 40 + romanToInteger xs 
romanToInteger ('X':'C':xs) = 90 + romanToInteger xs 
romanToInteger ('C':'D':xs) = 400 + romanToInteger xs 
romanToInteger ('C':'M':xs) = 900 + romanToInteger xs 
romanToInteger ('I':xs)     = 1 + romanToInteger xs 
romanToInteger ('V':xs)     = 5 + romanToInteger xs 
romanToInteger ('X':xs)     = 10 + romanToInteger xs 
romanToInteger ('L':xs)     = 50 + romanToInteger xs 
romanToInteger ('C':xs)     = 100 + romanToInteger xs 
romanToInteger ('D':xs)     = 500 + romanToInteger xs 
romanToInteger ('M':xs)     = 1000 + romanToInteger xs 

main = goTest 
    romanToInteger
    (unpack . textData . head)
    (intData . head . tail)
    (==)
    "../test_data/roman_to_integer.tsv"