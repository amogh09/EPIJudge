import TestFramework.TestRunner 
import qualified Data.Array as A

applyPerm :: [Int] -> [a] -> [a] 
applyPerm ps = A.elems . A.array (0, n-1) . zip ps 
    where n = length ps

main = goTest
    (uncurry applyPerm)
    (\(x:y:_) -> (intList x, intList y))
    (intList . head . drop 2)
    (==)
    "../test_data/apply_permutation.tsv"