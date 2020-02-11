import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.List (group)
import Data.Char (isDigit)
import Numeric (readDec)

encode :: String -> String 
encode xs = xs -- TODO

decode :: String -> String 
decode xs = xs -- TODO 

encodeDecodeWrapper :: (String,String) -> (String,String)
encodeDecodeWrapper (x,y) = (decode x,encode y)

chk :: (String,String) -> (String,String) -> Maybe String 
chk (x,y) (y',x')
    | x == x' && y == y' = Nothing 
    | x /= x' = Just $ show x ++ " doesn't match " ++ show x' 
    | y /= y' = Just $ show y ++ " doesn't match " ++ show y' 

main = goTestVoid 
    encodeDecodeWrapper
    (\(x:y:_) -> (unpack . textData $ x, unpack . textData $ y))
    chk
    "../test_data/run_length_compression.tsv"