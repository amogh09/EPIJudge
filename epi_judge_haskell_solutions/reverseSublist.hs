import TestFramework.TestRunner 

splitAt' :: Int -> [a] -> ([a],[a])
splitAt' _ [] = ([],[])
splitAt' i (x:xs)
    | i > 0 = let (ls,rs) = splitAt' (i-1) xs in (x:ls,rs)
    | otherwise = ([],x:xs)

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) [] 

reverseSublist :: Int -> Int -> [a] -> [a]
reverseSublist lo hi xs = 
    let (ps,rest) = splitAt' (lo-1) xs 
        (qs,rs)   = splitAt' (hi-lo+1) rest 
    in  ps ++ reverse' qs ++ rs

main = goTest 
    (uncurry2 reverseSublist)
    (\(x:y:z:_) -> (intData y, intData z, intList x))
    (intList . (!!3))
    (==)
    "../test_data/reverse_sublist.tsv"