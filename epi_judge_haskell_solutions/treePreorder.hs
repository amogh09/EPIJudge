import TestFramework.TestRunner 
import TestFramework.BinaryTree 
    (   Zipper, toZipper, goUp', isRoot, hasRightChild
    ,   hasLeftChild, focus, parent, ancestorIsRight, goRight
    ,   goLeft, zipperKey', emptyZipper
    )
import Data.Maybe (fromJust)

preorder :: (Eq a) => Zipper a -> [a]
preorder z | emptyZipper == z = []
preorder z = f . Just $ z where 
    f Nothing = [] 
    f (Just z) = zipperKey' z : f (succz z)

succz :: (Eq a) => Zipper a -> Maybe (Zipper a) 
succz z 
    | hasLeftChild . focus $ z = goLeft z 
    | hasRightChild . focus $ z = goRight z
    | otherwise = rightChildOfRightAncestor z

rightChildOfRightAncestor :: (Eq a) => Zipper a -> Maybe (Zipper a)
rightChildOfRightAncestor z 
    | isRoot z = Nothing
    | rightParent z && (hasRightChild . focus . goUp' $ z) = goRight . goUp' $ z
    | otherwise = rightChildOfRightAncestor . goUp' $ z

rightParent :: Zipper a -> Bool 
rightParent = ancestorIsRight . fromJust . parent

main = goTestWithInpDisp 
    preorder
    (toZipper . binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show . focus)
    "../test_data/tree_preorder.tsv"