import TestFramework.TestRunner 

validParenthesis :: String -> Bool
validParenthesis xs = False

main = goTest
    validParenthesis
    (stringData . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_valid_parenthesization.tsv"