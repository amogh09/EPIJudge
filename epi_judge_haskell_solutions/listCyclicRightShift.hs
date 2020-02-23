import TestFramework.TestRunner 

rotate :: Int -> [a] -> [a]
rotate _ [] = []
rotate k xs | k <= 0 = xs
rotate k xs = let (ls,rs) = splitAt k' xs in rs ++ ls where 
    n  = length xs 
    k' = n - (k `mod` n)

main = goTest 
    (uncurry rotate)
    (\(x:y:_) -> (intData y, intList x))
    (intList . (!!2))
    (==)
    "../test_data/list_cyclic_right_shift.tsv"