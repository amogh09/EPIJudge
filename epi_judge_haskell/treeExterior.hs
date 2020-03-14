import TestFramework.TestRunner 

exterior :: Tree a -> [a]
exterior t = [] -- TODO

main = goTestWithInpDisp
    exterior
    (binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/tree_exterior.tsv"