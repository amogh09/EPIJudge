import TestFramework.TestRunner 

increment :: [Int] -> [Int]
increment = reverse . f 1 . reverse where 
    f 1 [] = [1]
    f 0 xs = xs 
    f 1 (x:xs) = let (c,s) = (1+x) `quotRem` 10 in s : f c xs

main = goTest 
    increment 
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/int_as_array_increment.tsv"