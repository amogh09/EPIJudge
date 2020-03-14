import TestFramework.TestRunner 

-- Tree is defined as 
-- data Tree a = Empty | Tree a (Tree a) (Tree a)

leaves :: Tree a -> [a]
leaves t = [] -- TODO

main = goTestWithInpDisp
    leaves 
    (binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/tree_connect_leaves.tsv"