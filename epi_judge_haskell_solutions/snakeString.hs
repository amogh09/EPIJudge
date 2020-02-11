import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.List (partition)

snakeString :: String -> String 
snakeString xs = fmap snd $ ps ++ qs ++ rs where 
    (qs,rest) = partition (even . fst) . zip [0..] $ xs
    (ps,rs) = partition (\(i,_) -> (i-1) `mod` 4 == 0) $ rest

main = goTest 
    snakeString
    (unpack . textData . head)
    (unpack . textData . head . tail)
    (==)
    "../test_data/snake_string.tsv"