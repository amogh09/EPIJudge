import TestFramework.TestRunner 
import Data.Text (unpack)

reverseWords :: String -> String
reverseWords xs = xs -- TODO

main = goTest 
    reverseWords
    (unpack . textData . head)
    (unpack . textData . head . tail)
    (==)
    "../test_data/reverse_words.tsv"