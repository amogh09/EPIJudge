import TestFramework.TestRunner 
import qualified Data.Vector as V

search :: V.Vector Int -> Int 
search xs = f 0 (V.length xs - 1) where 
    f lo hi 
        | lo == hi = lo 
        | hi == lo + 1 = if xs V.! lo < xs V.! hi then lo else hi 
        | otherwise =
            let m = (lo + hi) `quot` 2
            in  if xs V.! m < V.last xs 
                    then f lo m 
                    else f m hi 

main = goTest
    search 
    (V.fromList . intList . head)
    (intData . head . tail)
    (==)
    "../test_data/search_shifted_sorted_array.tsv"