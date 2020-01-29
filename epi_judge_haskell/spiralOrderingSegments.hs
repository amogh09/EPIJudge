import TestFramework.TestRunner 
import qualified Data.Vector as V
import qualified Data.Set as S

spiralOrdering :: [[a]] -> [a]
spiralOrdering table = [] -- TODO

main = goTest 
    spiralOrdering
    (listOfIntList . head)
    (intList . head . tail)
    (==)
    "../test_data/spiral_ordering_segments.tsv"