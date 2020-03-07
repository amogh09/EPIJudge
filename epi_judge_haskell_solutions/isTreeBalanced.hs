import TestFramework.TestRunner 
import Data.Maybe (isJust)

isBalanced :: Tree a -> Bool 
isBalanced Empty = True 
isBalanced t = isJust $ heightIfBalanced t

heightIfBalanced :: Tree a -> Maybe Int 
heightIfBalanced Empty = Just 0 
heightIfBalanced (Tree _ l r) = 
    let lh = heightIfBalanced l 
        rh = heightIfBalanced r 
    in  case (lh,rh) of
            (Just lh, Just rh) | abs (lh - rh) <= 1 -> Just $ (max lh rh) + 1
            _ -> Nothing

main = goTestWithInpDisp
    isBalanced
    (binaryTree intData . head)
    (boolData . head . tail)
    (==)
    ((:[]) . show) 
    "../test_data/is_tree_balanced.tsv"
