import TestFramework.TestRunner
import Data.List (sort, partition)

rearrange :: Ord a => [a] -> [a]
rearrange xs = xs -- TODO 

isAlternating :: Ord a => [a] -> Bool 
isAlternating xs = f True (fmap snd evens) (fmap snd odds) where
    (evens, odds) = partition (even . fst) . zip [0..] $ xs
    f _ [] _ = True 
    f _ _ [] = True
    f True (x:xs) (y:ys)
        | x > y = False 
        | otherwise = f False xs (y:ys)
    f False (x:xs) (y:ys)
        | x < y = False 
        | otherwise = f True (x:xs) ys

chk :: Ord a => [a] -> [a] -> (Bool, String)
chk inp out = 
    if not (isAlternating out) 
        then (False, "Output is not alternating")
    else if sort inp /= sort out 
        then (False, "Output does not match elements from input")
        else (True, "")

main = goTestVoid 
    rearrange
    (intList . head)
    chk
    "../test_data/alternating_array.tsv"
