import TestFramework.TestRunner 
import Data.List (sort,find)

evenOdd :: [Int] -> [Int]
evenOdd xs = xs -- TODO

chk :: [Int] -> [Int] -> Maybe String
chk xs res = either Just (const Nothing) $ do
    let (es,os) = splitWhen odd res 
    rightIfNothing
        (\x -> "Odd element " ++ show x ++ " found in even part")
        (find odd es)
    rightIfNothing
        (\x -> "Even element " ++ show x ++ " found in odd part")
        (find even os)
    if length xs /= length res
        then Left "Result length does not match input length"
    else if sort xs /= sort res 
        then Left "Input elements do not match result elements"
        else Right ()

main = goTestVoid 
    evenOdd
    (intList . head)
    chk
    "../test_data/even_odd_array.tsv"