import           TestFramework.TestRunner

isConstructible :: (Ord a, Eq a) => [a] -> [a] -> Bool
isConstructible xs ys = True

main :: IO ()
main = goTest
  (uncurry isConstructible)
  (\(x:y:_) -> (stringData x, stringData y))
  (boolData . (!!2))
  (==)
  "../test_data/is_anonymous_letter_constructible.tsv"
