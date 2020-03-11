import TestFramework.TestRunner 
import TestFramework.BinaryTree (Zipper, zipperKey, goUp', goUp)
import Data.Maybe (fromJust)

lca :: (Eq a) => Zipper a -> Zipper a -> a
lca p q = 
    let (dp, dq) = (depth p, depth q)
    in  lcaSameDepth (goUpKTimes (dp - dq) p) (goUpKTimes (dq - dp) q)

lcaSameDepth :: (Eq a) => Zipper a -> Zipper a -> a 
lcaSameDepth z z' 
    | zipperKey z == zipperKey z' = fromJust $ zipperKey z 
    | otherwise = lcaSameDepth (goUp' z) (goUp' z')

goUpKTimes :: Int -> Zipper a -> Zipper a 
goUpKTimes k z
    | k <= 0 = z 
    | otherwise = goUpKTimes (k-1) . goUp' $ z

depth :: Zipper a -> Int 
depth z = 
    let p = goUp z  
    in  case p of 
            Nothing -> 0
            Just p  -> 1 + depth p

wrapper :: (Eq a, Show a) => a -> a -> Tree a -> a
wrapper x y t = lca (findZipper' x t) (findZipper' y t) 

main = goTestWithInpDisp
    (uncurry2 wrapper)
    (\(x:y:z:_) -> (intData y, intData z, binaryTree intData x))
    (intData . (!!3))
    (==)
    (\(x,y,z) -> [show z, show x, show y])
    "../test_data/lowest_common_ancestor.tsv"