import TestFramework.TestRunner 
import TestFramework.BinaryTree (Zipper, zipperKey')
import Data.Maybe (fromJust)

-- We are using a Zipper to move around the tree.
-- See module TestFramework.BinaryTree for API methods exposed
-- for Zippers and Trees.

lca :: (Eq a) => Zipper a -> Zipper a -> a
lca p q = zipperKey' p -- TODO

wrapper :: (Eq a, Show a) => a -> a -> Tree a -> a
wrapper x y t = lca (findZipper' x t) (findZipper' y t) 

main = goTestWithInpDisp
    (uncurry2 wrapper)
    (\(x:y:z:_) -> (intData y, intData z, binaryTree intData x))
    (intData . (!!3))
    (==)
    (\(x,y,z) -> [show z, show x, show y])
    "../test_data/lowest_common_ancestor.tsv"