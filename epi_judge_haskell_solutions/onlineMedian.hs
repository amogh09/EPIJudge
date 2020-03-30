import TestFramework.TestRunner 
import qualified Data.LeftistHeap as H 
import Data.Maybe (fromJust)

type OnlineMedian a = (Maybe a, H.LHeap a (), H.LHeap a ())

empty :: OnlineMedian a 
empty = (Nothing, H.empty, H.empty)

median :: (Fractional a) => OnlineMedian a -> a 
median (Just x, _, _) = x 
median (Nothing, l, r) = 
    let x = negate . fst . fromJust . H.getMin $ l 
        y = fst . fromJust . H.getMin $ r 
    in  (x+y) / 2

insert :: (Fractional a, Ord a) => a -> OnlineMedian a -> OnlineMedian a 
insert x (Nothing, l, r) | H.isEmpty l && H.isEmpty r = (Just x, l, r)
insert x m@(Nothing, l, r) | x <= median m = 
    let l' = H.insert (-x) () l 
        (x',_) = fromJust $ H.getMin l' 
    in  (Just $ negate x', H.delMin l', r)
insert x m@(Nothing, l, r) = 
    let r' = H.insert x () r 
        (x',_) = fromJust $ H.getMin r' 
    in  (Just x', l, H.delMin r')    
insert x (Just x', l, r) | x <= x' = (Nothing, H.insert (-x) () l, H.insert x' () r)
insert x (Just x', l, r) = (Nothing, H.insert (-x') () l, H.insert x () r)

onlineMedian :: (Integral a) => [a] -> [Double]
onlineMedian = reverse . snd . foldl f (empty,[]) . fmap (fromIntegral) where 
    f (h,ms) x = let h' = insert x h in (h', median h' : ms) 

main = goTest 
    onlineMedian
    (intList . head)
    (doubleList . head . tail)
    cmpDoubleList
    "../test_data/online_median.tsv"