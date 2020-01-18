import TestFramework.TestRunner 

reverseDigits :: Int -> Integer 
reverseDigits x = 0 -- TODO

main = goTest 
    reverseDigits
    (intData . head)
    (longData . head . tail)
    (==)
    "../test_data/reverse_digits.tsv"