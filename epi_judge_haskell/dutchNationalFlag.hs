import TestFramework.TestRunner 
import Data.List (sort)

dutchFlagPartition :: Int -> [Int] -> [Int]
dutchFlagPartition i xs = [] -- TODO 

chk :: (Int,[Int]) -> [Int] -> (Bool,String)
chk (i,xs) res = 
    if not . all (<pivot) $ ls 
        then (False, "Element greater than pivot found before elements equal to pivot")
    else if not . all (==pivot) $ ms 
        then (False, "Element not equal to pivot found when elements equal to pivot expected")
    else if not . all (>pivot) $ rs 
        then (False, "Element not greater than pivot found when elements greater than pivot expected")
    else if sort xs /= sort res 
        then (False, "Output either misses an element or contains an extra element")
        else (True, "")
    where
        pivot = xs !! i 
        (ls,rest) = splitWhen (==pivot) res 
        (ms,rs)   = splitWhen (>pivot) rest 

main = goTestVoid 
    (uncurry dutchFlagPartition)
    (\(x:y:_) -> (intData y, intList x))
    chk 
    "../test_data/dutch_national_flag.tsv"