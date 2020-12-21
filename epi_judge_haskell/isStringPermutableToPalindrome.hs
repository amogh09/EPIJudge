import           TestFramework.TestRunner

canFormPalindrome :: (Eq a, Ord a) => [a] -> Bool
canFormPalindrome xs = True

main :: IO ()
main = goTest
  canFormPalindrome
  (stringData . head)
  (boolData . (!!1))
  (==)
  "../test_data/is_string_permutable_to_palindrome.tsv"
