import TestFramework.TestRunner 
import TestFramework.BinaryTree 
    (   Zipper, toZipper, goUp', isRoot, hasRightChild
    ,   hasLeftChild, focus, parent, ancestorIsRight, goRight
    ,   goLeft, zipperKey', emptyZipper
    )

-- See helpful Zipper API in TestFramework.BinaryTree module.
-- Some helpful API methods for this problem are imported above.

preorder :: (Eq a) => Zipper a -> [a]
preorder z = [] -- TODO

main = goTestWithInpDisp 
    preorder
    (toZipper . binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show . focus)
    "../test_data/tree_preorder.tsv"