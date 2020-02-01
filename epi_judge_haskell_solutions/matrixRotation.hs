import TestFramework.TestRunner 
import qualified Data.Array as A

groupsOf :: Int -> [a] -> [[a]]
groupsOf _ [] = [] 
groupsOf n xs = let (ls,rs) = splitAt n xs in ls : groupsOf n rs

rotate :: [[a]] -> [[a]]
rotate table = groupsOf n . A.elems $ rotated where 
    atable = A.listArray ((0,0), (n-1,n-1)) [ x | row <- table, x <- row ]
    n = length table 
    ps = (if odd n then [replicate 4 (n `div` 2, n `div` 2)] else []) ++
        [ 
            [(i,j), (j,n-i-1), (n-i-1,n-j-1), (n-j-1,i)] 
        |   i <- [0..(n `div` 2)-1], j <- [0..n-i-2] 
        ]
    rotated = A.array ((0,0), (n-1,n-1)) $ do 
        [w,x,y,z] <- ps 
        [(w, atable A.! z), (x, atable A.! w), (y, atable A.! x), (z, atable A.! y)]

main = goTest 
    rotate 
    (listOfIntList . head)
    (listOfIntList . head . tail)
    (==)
    "../test_data/matrix_rotation.tsv"