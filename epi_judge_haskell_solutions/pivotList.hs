import TestFramework.TestRunner 
import Data.List (sort)

pivot :: (Ord a) => a -> [a] -> [a]
pivot x xs = ls ++ ms ++ rs where 
    (ls,ms,rs) = f xs
    f (y:ys) 
        | y < x  = let (ls,ms,rs) = f ys in (y:ls,ms,rs)
        | y == x = let (ls,ms,rs) = f ys in (ls,y:ms,rs)
        | y > x  = let (ls,ms,rs) = f ys in (ls,ms,y:rs)
    f [] = ([],[],[])

chk :: (Ord a, Show a) => (a,[a]) -> [a] -> Maybe String 
chk (x,xs) ys = 
    case f (-1) ys of 
        Nothing -> 
            if sort xs /= sort ys 
                then Just $ "Output " ++ show ys ++ " contains different values than input"  
                else Nothing
        Just err -> Just err
    where 
        f (-1) (y:ys) 
            | y >= x = f 0 (y:ys)
            | otherwise = f (-1) ys  
        f 0 (y:ys) 
            | y < x = Just $ "unexpected " ++ show y ++ " < " ++ show x ++ " found"
            | y > x = f 1 (y:ys)
            | otherwise = f 0 ys 
        f 1 (y:ys) 
            | y > x = f 1 ys 
            | otherwise = Just $ "unexpected " ++ show y ++ " <= " ++ show x ++ " found"
        f _ [] = Nothing

main = goTestVoid 
    (uncurry pivot)
    (\(x:y:_) -> (intData y, intList x))
    chk 
    "../test_data/pivot_list.tsv"