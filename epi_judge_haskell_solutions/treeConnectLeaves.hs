import TestFramework.TestRunner 

leaves :: Tree a -> [a]
leaves Empty = [] 
leaves (Tree x Empty Empty) = [x]
leaves (Tree _ l r) = leaves l ++ leaves r

main = goTestWithInpDisp
    leaves 
    (binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/tree_connect_leaves.tsv"