import TestFramework.TestRunner 
import Data.List (unfoldr)

pascal :: Int -> [[Int]]
pascal = flip take triangle where
    triangle = unfoldr f []
    f []   = Just ([1],[1])
    f prev = let next = [1] ++ [ x+y | (x,y) <- prev `zip` tail prev ] ++ [1]
             in  Just (next, next)

main = goTest 
    pascal 
    (intData . head)
    (listOfIntList . head . tail)
    (==)
    "../test_data/pascal_triangle.tsv"