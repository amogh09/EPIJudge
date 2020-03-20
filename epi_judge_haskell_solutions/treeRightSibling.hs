import TestFramework.TestRunner 
import TestFramework.BinaryTree (binaryTreeKey')

convert :: Tree a -> Tree a 
convert = foldr tieLevel Empty . fmap chain . levels where 
    chain = foldr (\x agg -> Tree x Empty agg) Empty 
    tieLevel (Tree x _ r) agg = Tree x agg r 

levels :: Tree a -> [[a]]
levels Empty = [] 
levels t = f [t] where  
    f [] = []
    f ts = (binaryTreeKey' <$> ts) : f (ts >>= children)

children :: Tree a -> [Tree a] -- assuming perfect binary tree]
children (Tree _ Empty Empty) = []
children (Tree _ l r) = [l,r]

rightSibLevels :: Tree a -> [[a]]
rightSibLevels = fmap breakChain . chains where 
    chains Empty = [] 
    chains (Tree x l r) = Tree x Empty r : chains l 
    breakChain Empty = [] 
    breakChain (Tree x _ r) = x : breakChain r

main = goTestWithInpDisp 
    (rightSibLevels . convert)
    (binaryTree intData . head)
    (listOfIntList . head . tail)
    (==)
    ((:[]) . show)
    "../test_data/tree_right_sibling.tsv"