import TestFramework.TestRunner 
import qualified Data.Vector as V

search :: V.Vector Int -> Int 
search xs = 0

main = goTest
    search 
    (V.fromList . intList . head)
    (intData . head . tail)
    (==)
    "../test_data/search_shifted_sorted_array.tsv"