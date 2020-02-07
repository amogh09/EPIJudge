import TestFramework.TestRunner 
import Data.Text (unpack)

breakAtSpaces :: String -> [String]
breakAtSpaces = foldr f [] where 
    f y [] = [[y]]
    f ' ' ((' ':xs):gs) = (' ':' ':xs) : gs
    f ' ' gs = " " : gs
    f y ((' ':xs):gs) = [y] : (' ':xs) : gs 
    f y (xs:gs) = (y:xs) : gs 

reverseWords :: String -> String
reverseWords = dropWhile (==' ') . concat . fmap reverse . breakAtSpaces . reverse

main = goTest 
    reverseWords
    (unpack . textData . head)
    (unpack . textData . head . tail)
    (==)
    "../test_data/reverse_words.tsv"