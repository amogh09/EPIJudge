import TestFramework.TestRunner 

delete :: (Eq a) => Int -> [a] -> [a]
delete i xs = xs -- TODO

main = goTest 
    (uncurry delete)
    (\(x:y:_) -> (intData y, intList x))
    (\(_:_:z:_) -> intList z)
    (==)
    "../test_data/delete_node_from_list.tsv"