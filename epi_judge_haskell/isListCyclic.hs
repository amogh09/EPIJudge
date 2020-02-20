import TestFramework.TestRunner 
import Data.List (elemIndex)
import Data.Maybe (fromJust)

isCyclic :: [Int] -> Int
isCyclic xs = -1 -- TODO

tie :: Int -> [Int] -> [Int]
tie (-1) xs = xs 
tie x xs = 
    let i = fromJust $ elemIndex x xs
        (ps,qs) = splitAt i xs 
    in  ps ++ cycle qs

main = goTest 
    isCyclic
    (\(x:y:_) -> tie (intData y) (intList x))
    (\(_:y:_) -> intData y)
    (==)
    "../test_data/is_list_cyclic.tsv"
