import TestFramework.TestRunner 
import Data.Maybe (fromJust)

kthNode :: Int -> Tree a -> a 
kthNode k = fromJust . snd . f 0 where 
    f :: Int -> Tree a -> (Int, Maybe a)
    f c Empty = (c, Nothing) 
    f c (Tree x l r) =
        let (c',res) = f c l
        in  case res of 
                Nothing -> if c' + 1 == k then (k, Just x) else f (c'+1) r 
                res -> (k, res) 

main = goTestWithInpDisp 
    (uncurry kthNode)
    (\(x:y:_) -> (intData y, binaryTree intData x))
    (intData . (!!2))
    (==)
    (\(x,y) -> [show y, show x])
    "../test_data/kth_node_in_tree.tsv"