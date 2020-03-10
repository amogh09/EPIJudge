import TestFramework.TestRunner 
import Data.Maybe (fromJust)

-- Tree is defined as 
-- data Tree a = Empty | Tree a (Tree a) (Tree a)

kthNode :: Int -> Tree a -> a 
kthNode k (Tree x _ _) = x -- TODO

main = goTestWithInpDisp 
    (uncurry kthNode)
    (\(x:y:_) -> (intData y, binaryTree intData x))
    (intData . (!!2))
    (==)
    (\(x,y) -> [show y, show x])
    "../test_data/kth_node_in_tree.tsv"