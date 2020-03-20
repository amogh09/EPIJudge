import TestFramework.TestRunner 

sumRootToLeaf :: Tree Int -> Int 
sumRootToLeaf Empty = 0
sumRootToLeaf t = sum . fmap toDec . f $ t where 
    f (Tree x Empty Empty) = [[x]]
    f (Tree x Empty r) = fmap (x:) $ f r
    f (Tree x l Empty) = fmap (x:) $ f l 
    f (Tree x l r) = fmap (x:) $ f l ++ f r 

toDec :: [Int] -> Int 
toDec = foldl (\agg x -> agg*2 + x) 0 where 

main = goTestWithInpDisp
    sumRootToLeaf
    (binaryTree intData . head)
    (intData . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/sum_root_to_leaf.tsv"