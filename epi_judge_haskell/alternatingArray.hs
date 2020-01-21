import TestFramework.TestRunner
import Data.List (sort, partition)

rearrange :: Ord a => [a] -> [a]
rearrange xs = xs -- TODO 

isAlternating :: Ord a => [a] -> Maybe (a,a) 
isAlternating xs = f True (fmap snd evens) (fmap snd odds) where
    (evens, odds) = partition (even . fst) . zip [0..] $ xs
    f _ [] _ = Nothing
    f _ _ [] = Nothing
    f True (x:xs) (y:ys)
        | x > y = Just (x,y) 
        | otherwise = f False xs (y:ys)
    f False (x:xs) (y:ys)
        | x > y = Just (y,x)
        | otherwise = f True (x:xs) ys

chk :: (Ord a, Show a) => [a] -> [a] -> Maybe String
chk inp out = 
    case isAlternating out of 
        Just (x,y) -> Just ("Output is not alternating: " ++ show (x,y) ++ " in " ++ show out) 
        _ -> if sort inp /= sort out 
                then Just "Output does not match elements from input"
                else Nothing

main = goTestVoid 
    rearrange
    (intList . head)
    chk
    "../test_data/alternating_array.tsv"
