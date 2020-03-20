import TestFramework.TestRunner
import Control.Applicative ((<|>))
import Data.Maybe (fromJust)

pathSum :: Int -> Tree Int -> Bool 
pathSum k t = True -- TODO

main = goTestWithInpDisp 
    (uncurry pathSum)
    (\(x:y:_) -> (intData y, binaryTree intData x))
    (boolData . (!!2))
    (==)
    (\(x,y) -> [show x, show y])
    "../test_data/path_sum.tsv"