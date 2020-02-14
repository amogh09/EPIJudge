import TestFramework.TestRunner 

delete :: Int -> [a] -> [a]
delete i xs = xs -- TODO

main = goTest 
    (uncurry delete)
    (\(x:y:_) -> (intData y, intList x))
    (intList . (!!2))
    (==)
    "../test_data/delete_from_list.tsv"