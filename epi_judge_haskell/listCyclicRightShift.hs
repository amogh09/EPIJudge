import TestFramework.TestRunner 

rotate :: Int -> [a] -> [a]
rotate k xs = xs -- TODO Fill here

main = goTest 
    (uncurry rotate)
    (\(x:y:_) -> (intData y, intList x))
    (intList . (!!2))
    (==)
    "../test_data/list_cyclic_right_shift.tsv"