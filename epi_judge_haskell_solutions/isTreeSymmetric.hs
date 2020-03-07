import TestFramework.TestRunner 

isSymmetric :: (Eq a) => Tree a -> Bool 
isSymmetric Empty = True 
isSymmetric (Tree _ l r) = symmetricTrees l r

symmetricTrees :: (Eq a) => Tree a -> Tree a -> Bool 
symmetricTrees Empty Empty = True 
symmetricTrees t Empty = False
symmetricTrees Empty t = False 
symmetricTrees (Tree x l r) (Tree x' l' r')
    | x /= x' = False 
    | otherwise = symmetricTrees l r' && symmetricTrees r l' 

main = goTestWithInpDisp
    isSymmetric
    (binaryTree intData . head)
    (boolData . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/is_tree_symmetric.tsv"