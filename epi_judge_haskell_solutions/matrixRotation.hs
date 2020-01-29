import TestFramework.TestRunner 
import qualified Data.Array as A

rotate :: (Show a) => [[a]] -> [[a]]
rotate table = table -- TODO

main = goTest 
    rotate 
    (listOfIntList . head)
    (listOfIntList . head . tail)
    (==)
    "../test_data/matrix_rotation.tsv"