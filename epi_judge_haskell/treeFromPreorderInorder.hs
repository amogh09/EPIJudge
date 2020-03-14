import TestFramework.TestRunner 

-- Tree is defined as 
-- data Tree a = Empty | Tree a (Tree a) (Tree a)

toTree :: (Eq a, Show a) => [a] -> [a] -> Tree a 
toTree ps is = Empty -- TODO

main = goTest
    (uncurry toTree)
    (\(x:y:_) -> (intList x, intList y))
    (binaryTree intData . (!!2))
    (==)
    "../test_data/tree_from_preorder_inorder.tsv"