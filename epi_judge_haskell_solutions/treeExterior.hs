import TestFramework.TestRunner 

exterior :: Tree a -> [a]
exterior Empty = [] 
exterior (Tree x Empty Empty) = [x]
exterior t = ls ++ ms ++ rs where
    ls = leftDiag t -- includes root 
    ms = case ls of 
            [_] -> leaves t -- if no left perimeter
            _  -> tail . leaves $ t -- otherwise exclude root
    rs = case ms of 
            [] -> rightDiag t -- if no left perimeter and no leaves
            _  -> tailSafe . rightDiag $ t -- otherwise exclude rightmost leaf

tailSafe :: [a] -> [a]
tailSafe [] = []
tailSafe (x:xs) = xs

leftDiag :: Tree a -> [a]
leftDiag (Tree x Empty _) = [x]
leftDiag t = f t where 
    f Empty = [] 
    f (Tree x Empty r) = x : f r 
    f (Tree x l _) = x : f l 

rightDiag :: Tree a -> [a]
rightDiag (Tree x _ Empty) = []
rightDiag t = reverse . tail . f $ t where
    f Empty = [] 
    f (Tree x l Empty) = x : f l 
    f (Tree x _ r) = x : f r

leaves :: Tree a -> [a]
leaves Empty = [] 
leaves (Tree x Empty Empty) = [x]
leaves (Tree _ l r) = leaves l ++ leaves r

main = goTestWithInpDisp
    exterior
    (binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/tree_exterior.tsv"