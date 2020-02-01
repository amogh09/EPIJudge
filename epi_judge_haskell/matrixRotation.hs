import TestFramework.TestRunner 
import qualified Data.Array as A

rotate :: [[a]] -> [[a]]
rotate table = [] -- TODO

main = goTest 
    rotate 
    (listOfIntList . head)
    (listOfIntList . head . tail)
    (==)
    "../test_data/matrix_rotation.tsv"