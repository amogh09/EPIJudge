import TestFramework.TestRunner
import Data.Text (unpack)

search :: String -> String -> Int 
search text sub = -1 -- TODO
        
main = goTest
    (uncurry search)
    (\(x:y:_) -> (unpack . textData $ x, unpack . textData $ y))
    (intData . (!!2))
    (==)
    "../test_data/substring_match.tsv"
    