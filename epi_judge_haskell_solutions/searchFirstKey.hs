import TestFramework.TestRunner 
import qualified Data.Vector as V

search :: (Ord a) => a -> V.Vector a -> Int
search _ xs | V.null xs = -1
search x xs = f 0 (V.length xs - 1) where 
    f lo hi | lo == hi = if xs V.! lo == x then lo else -1
    f lo hi = 
        let m = (lo + hi) `div` 2
        in  if x <= xs V.! m 
                then f lo m 
                else f (m+1) hi

main = goTest 
    (uncurry search)
    (\(x:y:_) -> (intData y, V.fromList . intList $ x))
    (intData . (!!2))
    (==)
    "../test_data/search_first_key.tsv"