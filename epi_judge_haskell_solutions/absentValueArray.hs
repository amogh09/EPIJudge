import           Data.Bits
import           TestFramework.TestRunner

nbits :: Int
nbits = 32

isBitClear :: Int -> Int -> Int
isBitClear n x = if x .&. (1 `shiftL` (nbits - n - 1)) == 0 then 1 else 0

findMissingElement :: [Int] -> Int
findMissingElement = snd . foldl f (0,0) . replicate nbits where
  f (n,x) xs =
    if foldl g 0 xs == 1 `shiftL` (nbits-n-1)
      then (n+1, setBit x $ nbits - n - 1)
      else (n+1, x)
    where
      g c y =
        if y `shiftR` (nbits - n) == x `shiftR` (nbits - n)
          then c + isBitClear n y
          else c

main = goTest
  findMissingElement
  (intList . head)
  (intData . (!! 1))
  (==)
  "../test_data/absent_value_array.tsv"
