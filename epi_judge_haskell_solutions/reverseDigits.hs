import TestFramework.TestRunner 

reverseDigits :: Int -> Integer 
reverseDigits x
    | x < 0 = negate . fromIntegral $ f 0 (-x)
    | otherwise = fromIntegral $ f 0 x 
    where 
        f r 0 = r 
        f r x = let d = x `mod` 10 in f (r*10 + d) (x `div` 10)

main = goTest 
    reverseDigits
    (intData . head)
    (longData . head . tail)
    (==)
    "../test_data/reverse_digits.tsv"