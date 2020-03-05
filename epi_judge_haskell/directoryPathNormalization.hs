import TestFramework.TestRunner 
import Data.List (intersperse,isPrefixOf)

normalize :: String -> String 
normalize xs = xs -- TODO

main = goTest 
    normalize
    (stringData . head)
    (stringData . head . tail)
    (==)
    "../test_data/directory_path_normalization.tsv"