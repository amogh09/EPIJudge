import TestFramework.TestRunner 
import Data.List (unfoldr)

pascal :: Int -> [[Int]]
pascal n = [] -- TODO

main = goTest 
    pascal 
    (intData . head)
    (listOfIntList . head . tail)
    (==)
    "../test_data/pascal_triangle.tsv"