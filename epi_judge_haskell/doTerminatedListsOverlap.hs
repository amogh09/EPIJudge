import TestFramework.TestRunner 
import Data.List (tails,find)

overlap :: (Eq a) => [a] -> [a] -> [a]
overlap xs ys = xs -- TODO

main = goTest 
    (uncurry overlap)
    (\(x:y:z:_) -> let zs = intList z in (intList x ++ zs, intList y ++ zs))
    (intList . (!!2))
    (==)
    "../test_data/do_terminated_lists_overlap.tsv"