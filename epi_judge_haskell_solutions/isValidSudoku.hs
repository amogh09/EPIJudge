import TestFramework.TestRunner 
import qualified Data.Map as M 
import qualified Data.Vector as V
import Data.List (foldl')

toCounter :: (Ord a) => [a] -> M.Map a Int 
toCounter = foldl' f M.empty where 
    f agg x = M.insertWith (+) x 1 agg

valsOk :: [Int] -> Bool 
valsOk = all (==1) . toCounter . filter (>0)

rowsOk :: [[Int]] -> Bool 
rowsOk = all valsOk 

colsOk :: V.Vector (V.Vector Int) -> Bool 
colsOk table = all id $
    [
        valsOk . V.toList $ (V.! j) <$> table
    |   j <- [0..V.length table - 1]
    ]    

gridsOk :: V.Vector (V.Vector Int) -> Bool 
gridsOk table = all id $ 
    [
        valsOk [
            (table V.! (3*i + i') V.! (3*j + j')) 
        |   i' <- [0..2], j' <- [0..2]
        ]
    |   i <- [0..2], j <- [0..2]
    ]

isValidSudoku :: [[Int]] -> Bool 
isValidSudoku table = rowsOk table && colsOk vTable && gridsOk vTable where 
    vTable = V.fromList <$> V.fromList table

main = goTest
    isValidSudoku
    (listOfIntList . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_valid_sudoku.tsv"