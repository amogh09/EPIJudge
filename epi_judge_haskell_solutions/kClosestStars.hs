import TestFramework.TestRunner 
import qualified Data.LeftistHeap as H
import Data.Maybe (fromJust)

kClosest :: Int -> [(Double, Double, Double)] -> [Double]
kClosest k = fmap fst . takeHeap k . H.fromList . fmap f where 
    f c@(x,y,z) = (sqrt (x**2 + y**2 + z**2), Nothing)

takeHeap :: (Ord a) => Int -> H.LHeap a b -> [(a,b)] 
takeHeap k h | k <= 0 || H.isEmpty h = []
takeHeap k h = fromJust (H.getMin h) : takeHeap (k-1) (H.delMin h) 

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