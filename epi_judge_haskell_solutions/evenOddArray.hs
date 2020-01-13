import TestFramework.TestRunner 
import Data.List (sort)

evenOdd :: [Int] -> [Int]
evenOdd xs = es ++ os where 
    es = filter even xs 
    os = filter odd xs

splitWhen :: (a -> Bool) -> [a] -> ([a],[a])
splitWhen p = f [] where
    f ls [] = (reverse ls,[])
    f ls (x:xs) 
        | p x = (reverse ls,x:xs)
        | otherwise = f (x:ls) xs

chk :: [Int] -> [Int] -> (Bool,String)
chk xs res = 
    let (_,os) = splitWhen odd res 
    in  if not . all odd $ os
            then (False, "Even element found in odd part")
        else if length xs /= length res
            then (False, "Result length does not match input length")
        else if sort xs /= sort res 
            then (False, "Input elements do not match result elements")
            else (True, "")

main = goTestVoid 
    evenOdd
    (intList . head)
    chk
    "../test_data/even_odd_array.tsv"