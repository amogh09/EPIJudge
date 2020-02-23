import TestFramework.TestRunner 
import Data.List (tails,find)

overlap :: (Eq a) => [a] -> [a] -> [a]
overlap xs ys = 
    case find (uncurry (==)) $ tails (drop k xs) `zip` tails (drop (-k) ys) of
        Nothing -> [] 
        Just (us,_) -> us 
    where 
        m = length xs 
        n = length ys 
        k = m - n
        
main = goTest 
    (uncurry overlap)
    (\(x:y:z:_) -> let zs = intList z in (intList x ++ zs, intList y ++ zs))
    (intList . (!!2))
    (==)
    "../test_data/do_terminated_lists_overlap.tsv"