import TestFramework.TestRunner 

toTree :: [Maybe a] -> Tree a 
toTree xs = Empty -- TODO

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