import TestFramework.TestRunner 
import qualified Data.LeftistHeap as H
import Data.Maybe (fromJust)

mergeLists :: (Ord a) => [[a]] -> [a]
mergeLists = f . H.fromList . fmap (\(x:xs) -> (x,xs)) where 
    f h | H.isEmpty h = [] 
    f h = 
        let (x,xs) = fromJust $ H.getMin h 
        in  case xs of
                []     -> x : f (H.delMin h)
                (y:ys) -> x : f (H.insert y ys . H.delMin $ h)    

main = goTest 
    mergeLists 
    (listOfIntList . head)
    (intList . head . tail)
    (==)
    "../test_data/sorted_arrays_merge.tsv"