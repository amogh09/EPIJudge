import TestFramework.TestRunner 

deleteKth :: Int -> [a] -> [a]
deleteKth k xs = 
    let (ls,rs) = splitAt' (length xs - k) xs
    in  case rs of 
            []     -> ls 
            (r:rs) -> ls ++ rs

splitAt' :: Int -> [a] -> ([a],[a])
splitAt' _ [] = ([],[])
splitAt' i (x:xs) 
    | i <= 0 = ([],x:xs)
    | otherwise = let (ls,rs) = splitAt' (i-1) xs in (x:ls, rs)

main = goTest 
    (uncurry deleteKth)
    (\(x:y:_) -> (intData y, intList x))
    (\(_:_:z:_) -> intList z)
    (==)
    "../test_data/delete_kth_last_from_list.tsv"