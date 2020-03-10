import TestFramework.TestRunner 
import Data.Maybe (fromJust)

-- Tree is defined as 
-- data Tree a = Empty | Tree a (Tree a) (Tree a)

lca :: (Eq a) => a -> a -> Tree a -> a
lca x y t = x -- TODO

main = goTestWithInpDisp
    (uncurry2 lca)
    (\(x:y:z:_) -> (intData y, intData z, binaryTree intData x))
    (intData . (!!3))
    (==)
    (\(x,y,z) -> [show z, show x, show y])
    "../test_data/lowest_common_ancestor.tsv"
