import TestFramework.TestRunner 
import Data.Text (unpack)

snakeString :: String -> String 
snakeString xs = xs -- TODO

main = goTest 
    snakeString
    (unpack . textData . head)
    (unpack . textData . head . tail)
    (==)
    "../test_data/snake_string.tsv"