import TestFramework.TestRunner 
import TestFramework.BinaryTree 
    (   toZipper, Zipper, zipperKey', zipperKey, focus, goRight', goLeft'
    ,   emptyZipper, parent, ancestorIsRight, goUp', isRoot
    ,   hasRightChild, hasLeftChild, isEmpty)
import Data.Maybe (fromJust, maybe)

-- See helpful Zipper API in TestFramework.BinaryTree module.
-- Some helpful API methods for this problem are imported above.

succz :: (Eq a) => Zipper a -> Maybe a
succz z = Nothing -- TODO

main = goTestWithInpDisp
    (\(t,x) -> maybe (-1) id $ succz (fromJust . findZipper x $ t))
    (\(t:x:_) -> (binaryTree intData t, intData x))
    (intData . (!!2))
    (==)
    (\(t,x) -> [show t, show x])
    "../test_data/successor_in_tree.tsv"