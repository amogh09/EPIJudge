import TestFramework.TestRunner 
import Data.List (sort,find)

dutchFlagPartition :: Int -> [Int] -> [Int]
dutchFlagPartition i xs = [] -- TODO 

chk :: (Int,[Int]) -> [Int] -> Maybe String
chk (i,xs) res = either Just (const Nothing) $ do 
    rightIfNothing 
        (\x -> "Element " ++ show x ++ " greater than pivot found before elements equal to pivot")
        (find (>=pivot) ls)
    rightIfNothing
        (\x -> "Element " ++ show x ++ " not equal to pivot found when elements equal to pivot expected")
        (find (/=pivot) ms)
    rightIfNothing
        (\x -> "Element " ++ show x ++ " not greater than pivot found when elements greater than pivot expected")
        (find (<=pivot) rs)
    if sort xs /= sort res 
        then Left "Output either misses an element or contains an extra element"
        else Right ()
    where
        pivot = xs !! i 
        (ls,rest) = splitWhen (==pivot) res 
        (ms,rs)   = splitWhen (>pivot) rest  

main = goTestVoid 
    (uncurry dutchFlagPartition)
    (\(x:y:_) -> (intData y, intList x))
    chk 
    "../test_data/dutch_national_flag.tsv"