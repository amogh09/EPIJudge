import TestFramework.TestRunner 

deleteKth :: Int -> [a] -> [a]
deleteKth k xs = xs -- TODO Fill here

main = goTest 
    (uncurry deleteKth)
    (\(x:y:_) -> (intData y, intList x))
    (\(_:_:z:_) -> intList z)
    (==)
    "../test_data/delete_kth_last_from_list.tsv"