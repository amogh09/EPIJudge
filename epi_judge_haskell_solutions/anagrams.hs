import           Data.List                (sort)
import qualified Data.Map                 as M
import           TestFramework.TestRunner

findAnagrams :: [String] -> [[String]]
findAnagrams =
    filter ((>1) . length)
  . M.elems
  . foldr (\w -> M.insertWith (++) (sort w) [w]) M.empty

main :: IO ()
main = goTest
  findAnagrams
  (stringList . head)
  (listOfStringList . (!!1))
  (\x y -> sort x == sort y)
  "../test_data/anagrams.tsv"
