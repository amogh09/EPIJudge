import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.List (group,unfoldr)

looksAndSays :: [String]
looksAndSays = unfoldr f "0" where 
    f "0" = Just ("1", "1")
    f xs  = let xs' = concat . fmap (\g -> show (length g) ++ [head g]) . group $ xs
            in  Just (xs',xs')

lookAndSay :: Int -> String 
lookAndSay x = looksAndSays !! (x-1)

main = goTest
    lookAndSay
    (intData . head)
    (unpack . textData . head . tail)
    (==)
    "../test_data/look_and_say.tsv"