import TestFramework.TestRunner 

toTree :: (Eq a, Show a) => [a] -> [a] -> Tree a 
toTree [] [] = Empty
toTree ps is = Tree x l r where 
    x = head ps  
    (lis,ris) = splitWhen' (==x) is 
    (lps,rps) = splitAt (length lis) . tail $ ps 
    l = toTree lps lis 
    r = toTree rps ris 

splitWhen' :: (a -> Bool) -> [a] -> ([a],[a])
splitWhen' _ [] = ([],[])
splitWhen' f (x:xs)
    | f x = ([],xs)
    | otherwise = let (ls,rs) = splitWhen' f xs in (x:ls,rs)

main = goTest
    (uncurry toTree)
    (\(x:y:_) -> (intList x, intList y))
    (binaryTree intData . (!!2))
    (==)
    "../test_data/tree_from_preorder_inorder.tsv"