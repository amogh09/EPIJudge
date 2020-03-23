import TestFramework.TestRunner 
import qualified Data.LeftistHeap as H
import Data.Maybe (fromJust)

kClosest :: Int -> [(Double, Double, Double)] -> [Double]
kClosest k cs = [] -- TODO

pointData :: Data -> (Double, Double, Double)
pointData p = (doubleData x, doubleData y, doubleData z) where 
    (x,y,z) = tuple3Data p

dblEq :: Double -> Double -> Bool
dblEq x y = abs (x - y) <= 0.00001

main = goTest
    (uncurry kClosest)
    (\(x:y:_) -> (intData y, listData pointData x))
    (listData doubleData . (!!2))
    (\xs ys -> length xs == length ys && (all (uncurry dblEq) . zip xs $ ys))
    "../test_data/k_closest_stars.tsv"