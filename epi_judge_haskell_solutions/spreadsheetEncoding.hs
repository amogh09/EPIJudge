import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.Char (ord)
import Data.List (foldl')

decode :: String -> Int
decode = foldl' f 0 where
    f s x = s*26 + (ord x - ord 'A' + 1)

main = goTest 
    decode 
    (unpack . textData . head)
    (intData . head . tail)
    (==)
    "../test_data/spreadsheet_encoding.tsv"