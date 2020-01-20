import TestFramework.TestRunner

nextPerm :: [Int] -> [Int]
nextPerm xs = if notFst then res else [] where
    (notFst, res) = foldr f (False,[]) xs 
    f x (_, []) = (False, [x])
    f x (False, (x':xs))
        | x >= x'   = (False, x:x':xs)
        | otherwise = let (ls,r:rs) = splitWhenSnd (<=x) (x':xs) 
                      in  (True, r : reverse (ls ++ x:rs))
    f x (True, xs) = (True, x:xs)

splitWhenSnd :: (a -> Bool) -> [a] -> ([a],[a])
splitWhenSnd _ [x] = ([],[x])
splitWhenSnd p (x:x':xs)
    | p x' = ([],x:x':xs)
    | otherwise = let (ls,rs) = splitWhenSnd p (x':xs) 
                  in  (x:ls,rs)

main = goTest 
    nextPerm
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/next_permutation.tsv"