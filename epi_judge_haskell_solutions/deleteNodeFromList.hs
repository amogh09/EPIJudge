import TestFramework.TestRunner 

delete :: (Eq a) => Int -> [a] -> [a]
delete _ [] = [] 
delete 0 (x:xs) = xs 
delete i (x:xs) = x : delete (i-1) xs

main = goTest 
    (uncurry delete)
    (\(x:y:_) -> (intData y, intList x))
    (\(_:_:z:_) -> intList z)
    (==)
    "../test_data/delete_node_from_list.tsv"