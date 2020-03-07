import TestFramework.TestRunner 
import Data.Maybe (isJust)

isBalanced :: Tree a -> Bool 
isBalanced t = True 

main = goTestWithInpDisp
    isBalanced
    (binaryTree intData . head)
    (boolData . head . tail)
    (==)
    ((:[]) . show) 
    "../test_data/is_tree_balanced.tsv"
