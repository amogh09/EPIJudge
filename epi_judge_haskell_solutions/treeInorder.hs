import TestFramework.TestRunner 
import TestFramework.BinaryTree 
    (
        Zipper
    ,   toZipper
    ,   goUp'
    ,   goRight'
    ,   goLeft'
    ,   focus
    ,   zipperKey'
    ,   parent 
    ,   ancestorIsRight
    ,   isRoot
    ,   hasRightChild
    ,   hasLeftChild
    ,   emptyZipper
    )
import Data.Maybe (fromJust)
import Control.Applicative ((<|>))

inorder :: (Eq a) => Zipper a -> [a]
inorder z | z == emptyZipper = []
inorder z = f . Just . leftMost $ z where 
    f Nothing = []
    f (Just z) = zipperKey' z : f (succz z)

leftMost :: (Eq a) => Zipper a -> Zipper a 
leftMost z | hasLeftChild . focus $ z = leftMost . goLeft' $ z 
leftMost z = z

succz :: (Eq a) => Zipper a -> Maybe (Zipper a) 
succz z = fromRight z <|> fromTop z

fromRight :: (Eq a) => Zipper a -> Maybe (Zipper a)
fromRight z | hasRightChild . focus $ z = Just . leftMost . goRight' $ z
fromRight _ = Nothing

fromTop :: Zipper a -> Maybe (Zipper a)
fromTop z
    | isRoot z = Nothing
    | rightParent z = Just $ goUp' z
    | otherwise = fromTop $ goUp' z

rightParent :: Zipper a -> Bool 
rightParent = ancestorIsRight . fromJust . parent

main = goTestWithInpDisp
    inorder
    (toZipper . binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show . focus)
    "../test_data/tree_inorder.tsv"