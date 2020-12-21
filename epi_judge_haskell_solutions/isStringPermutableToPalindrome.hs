import qualified Data.Map                 as M
import           TestFramework.TestRunner

toCounter :: (Eq a, Ord a) => [a] -> M.Map a Int
toCounter = foldr (\x -> M.insertWith (+) x 1) M.empty

canFormPalindrome :: (Eq a, Ord a) => [a] -> Bool
canFormPalindrome xs = check . M.toList . toCounter $ xs where
  check ps | even (length xs) = all (even . snd) ps
  check ps = (==1) . length . filter (odd . snd) $ ps

main :: IO ()
main = goTest
  canFormPalindrome
  (stringData . head)
  (boolData . (!!1))
  (==)
  "../test_data/is_string_permutable_to_palindrome.tsv"
