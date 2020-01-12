import TestFramework.TestRunner 

reverseDigits :: Int -> Integer 
reverseDigits x
    | x < 0 = negate . fromIntegral $ f 0 (-x)
    | otherwise = fromIntegral $ f 0 x 
    where 
        f r 0 = r 
        f r x = let d = x `mod` 10 in f (r*10 + d) (x `div` 10)

isNumberPalindromic :: Int -> Bool 
isNumberPalindromic x 
    | x < 0 = False 
    | otherwise = (fromIntegral x) == reverseDigits x

main = goTest 
    isNumberPalindromic
    (intData . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_number_palindromic.tsv"