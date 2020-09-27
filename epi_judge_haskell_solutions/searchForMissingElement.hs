import           Data.Bifunctor           (bimap)
import           Data.Bits
import           Data.List
import           TestFramework.TestRunner

findDuplicateMissing :: [Int] -> (Int,Int)
findDuplicateMissing xs = do
  let
    n = length xs
    xr = foldl1' xor [0..n-1] `xor` foldl1' xor xs
    diffBitAt = head . filter (testBit xr) $ [0..31]
    dupOrMiss = foldl' xor 0 [x | x <- [0..n-1], testBit x diffBitAt]
                `xor`
                foldl' xor 0 [x | x <- xs, testBit x diffBitAt]
  if dupOrMiss `elem` xs
    then (dupOrMiss, xr `xor` dupOrMiss)
    else (xr `xor` dupOrMiss, dupOrMiss)

main = goTest
  findDuplicateMissing
  (intList . head)
  (bimap intData intData . tuple2Data . (!!1))
  (==)
  "../test_data/find_missing_and_duplicate.tsv"
