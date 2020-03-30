import TestFramework.TestRunner 
import qualified Data.Vector as V

search :: (Ord a) => a -> V.Vector a -> Int
search x xs = -1

main = goTest 
    (uncurry search)
    (\(x:y:_) -> (intData y, V.fromList . intList $ x))
    (intData . (!!2))
    (==)
    "../test_data/search_first_key.tsv"