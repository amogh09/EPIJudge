import TestFramework.TestRunner 

multiply :: [Int] -> [Int] -> [Int]
multiply xs ys = xs -- TODO

main = goTest 
    (uncurry multiply)
    (listToTuple2 . fmap intList . take 2)
    (intList . (!! 2))
    (==)
    "../test_data/int_as_array_multiply.tsv"