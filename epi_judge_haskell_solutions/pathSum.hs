import TestFramework.TestRunner
import Control.Applicative ((<|>))
import Data.Maybe (fromJust)

pathSum :: Int -> Tree Int -> Bool 
pathSum k = maybe False id . f [] where 
    f xs Empty = Nothing 
    f xs (Tree x Empty Empty) = 
        if sum (x:xs) == k then Just True else Nothing
    f xs (Tree x l r) = f (x:xs) l <|> f (x:xs) r

main = goTestWithInpDisp 
    (uncurry pathSum)
    (\(x:y:_) -> (intData y, binaryTree intData x))
    (boolData . (!!2))
    (==)
    (\(x,y) -> [show x, show y])
    "../test_data/path_sum.tsv"