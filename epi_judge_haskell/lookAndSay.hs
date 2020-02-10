import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.List (group,unfoldr)

lookAndSay :: Int -> String 
lookAndSay x = "" -- TODO

main = goTest
    lookAndSay
    (intData . head)
    (unpack . textData . head . tail)
    (==)
    "../test_data/look_and_say.tsv"