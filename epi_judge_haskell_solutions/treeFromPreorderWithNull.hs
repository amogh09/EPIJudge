import TestFramework.TestRunner 

toTree :: [Maybe a] -> Tree a 
toTree = fst . f where 
    f (Nothing:xs) = (Empty, xs)
    f (Just x:Nothing:Nothing:xs) = (Tree x Empty Empty, xs) 
    f (Just x:xs) = 
        let (l,xs')  = f xs 
            (r,xs'') = f xs'
        in  (Tree x l r, xs'')

fin :: TestCase -> [Maybe Int]
fin = fmap f . textList . head where 
    f "null" = Nothing 
    f x = Just $ fastReadInt x

main = goTest 
    toTree 
    fin
    (binaryTree intData . head . tail)
    (==)
    "../test_data/tree_from_preorder_with_null.tsv"