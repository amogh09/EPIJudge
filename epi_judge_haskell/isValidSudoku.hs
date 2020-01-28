import TestFramework.TestRunner 
import qualified Data.Map as M 
import qualified Data.Vector as V
import Data.List (foldl')

isValidSudoku :: [[Int]] -> Bool 
isValidSudoku table = True -- TODO

main = goTest
    isValidSudoku
    (listOfIntList . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_valid_sudoku.tsv"