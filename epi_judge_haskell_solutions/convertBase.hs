import TestFramework.TestRunner 
import Data.Text (unpack)
import qualified Data.Map as M
import Data.Char (digitToInt, intToDigit, toUpper)

toBase10 :: Int -> String -> Int 
toBase10 b xs = foldl f 0 xs where 
    f s x = s*(fromIntegral b) + fromIntegral (digitToInt x)

fromBase10 :: Int -> Int -> String 
fromBase10 b 0 = "0"
fromBase10 b x = reverse $ f x where 
    f 0 = ""
    f x | x < b = [toUpper . intToDigit $ x]
    f x = let (q,r) = x `quotRem` b in (toUpper . intToDigit $ r) : f q

convertBase :: Int -> Int -> String -> String 
convertBase b b' ('-':xs) = '-' : (fromBase10 b' . toBase10 b $ xs)
convertBase b b' xs = fromBase10 b' . toBase10 b $ xs

fin :: TestCase -> (Int, Int, String)
fin (x:y:z:_) = (   
        fromIntegral . intData $ y
    ,   fromIntegral . intData $ z
    ,   unpack . textData $ x
    )

main = goTest 
    (uncurry2 convertBase)
    fin 
    (unpack . textData . (!!3))
    (==)
    "../test_data/convert_base.tsv"