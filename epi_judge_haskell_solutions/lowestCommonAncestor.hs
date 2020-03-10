import TestFramework.TestRunner 
import Data.Maybe (fromJust)

lca :: (Eq a) => a -> a -> Tree a -> a
lca x y t
    | x == y = x
    | otherwise = fromJust . snd . f $ t where 
    f Empty = (0, Nothing)
    f (Tree z l r)
        | z `elem` [x,y] = 
            let ((lc, _), (rc, _)) = (f l, f r)
            in  if lc + rc == 1
                    then (2, Just z)
                    else (1, Nothing)
        | otherwise = 
            let ((lc, lr), (rc, rr)) = (f l, f r)
            in  case (lc,rc) of 
                    (0, 0)  -> (0, Nothing)
                    (1, 1)  -> (2, Just z)            
                    (lc, 0) -> (lc, lr)
                    (0, rc) -> (rc, rr)

main = goTestWithInpDisp
    (uncurry2 lca)
    (\(x:y:z:_) -> (intData y, intData z, binaryTree intData x))
    (intData . (!!3))
    (==)
    (\(x,y,z) -> [show z, show x, show y])
    "../test_data/lowest_common_ancestor.tsv"
