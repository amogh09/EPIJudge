import TestFramework.TestRunner 
import Data.List (find,elemIndex)
import Data.Maybe (fromJust)

steps :: Int -> [a] -> [[a]]
steps _ [] = []
steps k xs = 
    let xs' = drop k xs 
    in  case xs' of 
            [] -> []
            _  -> xs' : steps k xs'

isCyclic :: [Int] -> [Int]
isCyclic xs = 
    case k of 
        Nothing -> []
        Just (_,qs) -> fst . fromJust . find f $
            ([head xs]:steps 1 xs) `zip` ([head qs]:steps 1 qs)
    where 
        k = find f $ steps 1 xs `zip` steps 2 xs
        f ((x:_), (y:_)) = x == y

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
