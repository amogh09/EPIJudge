import qualified Data.Map                 as M
import           TestFramework.TestRunner

toCounter :: (Eq a, Ord a) => [a] -> M.Map a Int
toCounter = foldr (\x -> M.insertWith (+) x 1) M.empty

isConstructible :: (Ord a, Eq a) => [a] -> [a] -> Bool
isConstructible xs ys =
  let
    cxs = toCounter xs
    cys = toCounter ys
  in
    all (\(x,c) -> M.findWithDefault 0 x cys - c >= 0) . M.toList $ cxs

main :: IO ()
main = goTest
  (uncurry isConstructible)
  (\(x:y:_) -> (stringData x, stringData y))
  (boolData . (!!2))
  (==)
  "../test_data/is_anonymous_letter_constructible.tsv"
