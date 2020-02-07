import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.Char (ord)
import Data.List (foldl')

decode :: String -> Int
decode xs = 0 -- TODO

main = goTest 
    decode 
    (unpack . textData . head)
    (intData . head . tail)
    (==)
    "../test_data/spreadsheet_encoding.tsv"