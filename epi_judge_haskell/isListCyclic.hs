import TestFramework.TestRunner 
import Data.List (find,elemIndex)
import Data.Maybe (fromJust)

isCyclic :: [Int] -> [Int]
isCyclic xs = []

tie :: Int -> [Int] -> [Int]
tie (-1) xs = xs 
tie x xs = 
    let i = fromJust $ elemIndex x xs
        (ps,qs) = splitAt i xs 
    in  ps ++ cycle qs

wrapper :: (Int,[Int]) -> [Int]
wrapper (x,xs) = isCyclic $ tie x xs

chk :: (Int,[Int]) -> [Int] -> Maybe String 
chk (x,xs) []     = if x == -1 then Nothing else Just "Cycle expected" 
chk (x,xs) (c:cs) = 
    if x == c  
        then Nothing 
        else Just $ "Actual cycle start " ++ show c ++ " not equal to returned " ++ show x

main = goTestVoid
    wrapper
    (\(x:y:_) -> (intData y, intList x))
    chk
    "../test_data/is_list_cyclic.tsv"
