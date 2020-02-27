import TestFramework.TestRunner

evenOddMerge :: [a] -> [a]
evenOddMerge xs = fmap snd ls ++ fmap snd rs where 
    (ls,rs) = partition (even . fst) ([0..] `zip` xs)

partition :: (a -> Bool) -> [a] -> ([a],[a])
partition f [] = ([],[])
partition f (x:xs) = let (ls,rs) = partition f xs 
                     in  if f x then (x:ls,rs) else (ls,x:rs)

main = goTest 
    evenOddMerge
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/even_odd_list_merge.tsv"