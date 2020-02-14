import TestFramework.TestRunner 

reverseSublist :: Int -> Int -> [a] -> [a]
reverseSublist lo hi xs = xs -- TODO

main = goTest 
    (uncurry2 reverseSublist)
    (\(x:y:z:_) -> (intData y, intData z, intList x))
    (intList . (!!3))
    (==)
    "../test_data/reverse_sublist.tsv"