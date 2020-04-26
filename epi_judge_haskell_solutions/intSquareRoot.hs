import TestFramework.TestRunner 

sqroot :: Int -> Int 
sqroot x = f 0 x where
    f lo hi | lo == hi = lo 
    f lo hi | lo + 1 == hi && hi*hi <= x = hi 
    f lo hi | lo + 1 == hi = lo
    f lo hi = 
        let m = (lo + hi) `quot` 2
        in  if m*m < x 
                then f m hi
            else if m*m == x
                then m 
                else f lo (m-1)

main = goTest 
    sqroot
    (intData . head)
    (intData . head . tail)
    (==)
    "../test_data/int_square_root.tsv"