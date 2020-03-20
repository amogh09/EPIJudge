import TestFramework.TestRunner 
import TestFramework.BinaryTree (binaryTreeKey')

-- Converts Tree from a form
-- Tree x <Left Child> <Right Child> to a form
-- Tree x <Next Level> <Right Sibling in current level>
convert :: Tree a -> Tree a 
convert t = t -- TODO

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