import TestFramework.TestRunner 
import qualified Data.Text as T

atoi :: String -> Int
atoi xs = 0

itoa :: Int -> String 
itoa x = "0"

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