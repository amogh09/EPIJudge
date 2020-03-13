import TestFramework.TestRunner 
import TestFramework.BinaryTree 
    (   toZipper, Zipper, zipperKey', zipperKey, focus, goRight', goLeft'
    ,   emptyZipper, parent, ancestorIsRight, goUp', isRoot
    ,   hasRightChild, hasLeftChild, isEmpty)
import Control.Applicative ((<|>))
import Data.Maybe (fromJust, maybe)

succz :: (Eq a) => Zipper a -> Maybe a
succz z = fromRight z <|> fromTop z >>= zipperKey

fromRight :: Zipper a -> Maybe (Zipper a)
fromRight z | hasRightChild . focus $ z = Just . leftMost . goRight' $ z
fromRight _ = Nothing 

fromTop :: Zipper a -> Maybe (Zipper a)
fromTop z 
    | isRoot z = Nothing 
    | rightParent z = Just . goUp' $ z 
    | otherwise = fromTop . goUp' $ z

rightParent :: Zipper a -> Bool 
rightParent = ancestorIsRight . fromJust . parent

leftMost :: Zipper a -> Zipper a 
leftMost z | hasLeftChild . focus $ z = leftMost . goLeft' $ z
leftMost z = z

main = goTestWithInpDisp
    (\(t,x) -> maybe (-1) id $ succz (fromJust . findZipper x $ t))
    (\(t:x:_) -> (binaryTree intData t, intData x))
    (intData . (!!2))
    (==)
    (\(t,x) -> [show t, show x])
    "../test_data/successor_in_tree.tsv"