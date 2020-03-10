import TestFramework.TestRunner
import Data.Maybe (fromJust)

-- Tree is defined as 
-- data Tree a = Empty | Tree a (Tree a) (Tree a)

levels :: Tree a -> [[a]]
levels Empty = [] 
levels t = [key t] : f [t] where 
    f [] = []
    f ts = 
        let level = ts >>= children 
            keys  = [key l | l <- level] 
        in  case level of 
                [] -> []
                _  -> keys : f level

children :: Tree a -> [Tree a]
children (Tree _ Empty Empty) = [] 
children (Tree _ l Empty) = [l]
children (Tree _ Empty r) = [r]
children (Tree _ l r) = [l,r]

key :: Tree a -> a
key (Tree k _ _) = k

main = goTestWithInpDisp 
    levels
    (binaryTree intData . head)
    (listData intList . head . tail)
    (==)
    (:[])
    "../test_data/tree_level_order.tsv"