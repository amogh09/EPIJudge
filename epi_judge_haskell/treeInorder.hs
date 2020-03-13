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

-- See helpful Zipper API in TestFramework.BinaryTree module.
-- Some helpful API methods for this problem are imported above.

inorder :: (Eq a) => Zipper a -> [a]
inorder z = [] -- TODO Implement inorder traversal on a Zipper

main = goTestWithInpDisp
    inorder
    (toZipper . binaryTree intData . head)
    (intList . head . tail)
    (==)
    ((:[]) . show . focus)
    "../test_data/tree_inorder.tsv"