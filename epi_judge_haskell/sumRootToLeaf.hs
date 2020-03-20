import TestFramework.TestRunner 

sumRootToLeaf :: Tree Int -> Int 
sumRootToLeaf t = 0 -- TODO

main = goTestWithInpDisp
    sumRootToLeaf
    (binaryTree intData . head)
    (intData . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/sum_root_to_leaf.tsv"