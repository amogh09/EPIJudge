import TestFramework.TestRunner 
import Data.List (partition)
import qualified Data.LeftistHeap as H
import Data.Maybe (fromJust)

sort :: (Ord a) => [a] -> [a]
sort xs = mergeLists $ (snd <$> incs) ++ (reverse <$> snd <$> decs) where 
    (incs, decs) = partition (even . fst) . zip [0..] . extractSorted $ xs

extractSorted :: (Ord a) => [a] -> [[a]]
extractSorted = f True where 
    f incr (x:x':xs) | (incr && x <= x') || (not incr && x >= x') = 
        let (ys:rest) = f incr (x':xs)
        in  (x:ys) : rest 
    f incr (x:x':xs) = [x] : f (not incr) (x':xs)
    f _ [x] = [[x]]
    f _ []  = []

mergeLists :: (Ord a) => [[a]] -> [a]
mergeLists = f . H.fromList . fmap (\(x:xs) -> (x,xs)) where 
    f h | H.isEmpty h = [] 
    f h = 
        let (x,xs) = fromJust $ H.getMin h 
        in  case xs of
                []     -> x : f (H.delMin h)
                (y:ys) -> x : f (H.insert y ys . H.delMin $ h)

main = goTest 
    sort 
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/sort_increasing_decreasing_array.tsv"