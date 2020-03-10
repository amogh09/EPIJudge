import TestFramework.TestRunner
import Data.Maybe (fromJust)

-- Tree is defined as 
-- data Tree a = Empty | Tree a (Tree a) (Tree a)

levels :: Tree a -> [[a]]
levels t = [] -- TODO 

main = goTestWithInpDisp 
    levels
    (binaryTree intData . head)
    (listData intList . head . tail)
    (==)
    (:[])
    "../test_data/tree_level_order.tsv"