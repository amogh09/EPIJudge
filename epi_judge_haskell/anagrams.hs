import           Data.List                (sort)
import qualified Data.Map                 as M
import           TestFramework.TestRunner

findAnagrams :: [String] -> [[String]]
findAnagrams ws = [] -- TODO

main :: IO ()
main = goTest
  findAnagrams
  (stringList . head)
  (listOfStringList . (!!1))
  (\x y -> sort x == sort y)
  "../test_data/anagrams.tsv"
