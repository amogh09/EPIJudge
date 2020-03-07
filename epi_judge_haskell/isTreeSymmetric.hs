import TestFramework.TestRunner 

isSymmetric :: (Eq a) => Tree a -> Bool 
isSymmetric t = True

main = goTestWithInpDisp
    isSymmetric
    (binaryTree intData . head)
    (boolData . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/is_tree_symmetric.tsv"