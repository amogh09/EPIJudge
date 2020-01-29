import TestFramework.TestRunner 
import qualified Data.Text as T
import Data.Char (ord,chr)

atoi :: String -> Int
atoi ('-':xs) = negate . atoi $ xs 
atoi xs = foldl f 0 xs where 
    f s x = s*10 + (ord x - ord '0')

itoa :: Int -> String 
itoa 0 = "0"
itoa x 
    | x < 0 = '-' : itoa (abs x)
    | otherwise = reverse $ f x 
    where 
        f 0 = ""
        f x = let d = chr $ ord '0' + (x `mod` 10) in d : f (x `div` 10)

wrapper :: (Int, String) -> (String,Int)
wrapper (x,xs) = (itoa x, atoi xs)

chk :: (Int,String) -> (String,Int) -> Maybe String 
chk (x,xs) (ys,y)
    | x /= y = Just $ "Input " ++ show x ++ " was converted to " ++ show y
    | xs /= ys = Just $ "Input " ++ xs ++ " was converted to " ++ ys 
    | otherwise = Nothing 

main = goTestVoid
    wrapper
    (\(x:y:_) -> (intData x, T.unpack $ textData y))
    chk 
    "../test_data/string_integer_interconversion.tsv"