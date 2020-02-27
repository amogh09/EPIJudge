import TestFramework.TestRunner 

add :: [Int] -> [Int] -> [Int]
add xs = f 0 xs where
    f c (x:xs) (y:ys) = let (c',s) = (c+x+y) `quotRem` 10 in s : f c' xs ys
    f c (x:xs) [] = let (c',s) = (c+x) `quotRem` 10 in s : f c' xs []
    f c [] (y:ys) = f c (y:ys) []
    f 0 [] [] = []
    f c [] [] = [c]

main = goTest 
    (uncurry add)
    (\(x:y:_) -> (intList x, intList y))
    (intList . (!!2))
    (==)
    "../test_data/int_as_list_add.tsv"