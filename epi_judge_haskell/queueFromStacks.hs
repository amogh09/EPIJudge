import TestFramework.TestRunner 

data Queue a = Queue -- TODO

empty :: Queue a
empty = Queue -- TODO

enqueue :: a -> Queue a -> Queue a 
enqueue x q = q -- TODO

dequeue :: Queue a -> (a, Queue a)
dequeue q = (0,q) -- TODO

size :: Queue a -> Int 
size q = 0 -- TODO

chk :: [(String, Int)] -> Maybe String 
chk = f empty where 
    f _ [] = Nothing
    f q (("Queue", _):ps)   = f empty ps 
    f q (("enqueue", x):ps) = f (enqueue x q) ps
    f q (("dequeue", x):ps) =
        let (y,q') = dequeue q 
        in  if x /= y 
                then Just $ "Dequeued " ++ show y ++ " not equal to expected " ++ show x
                else f q' ps 
    f q (("size", m):ps) = 
        let n = size q 
        in  if m /= n 
                then Just $ "Size " ++ show n ++ " not equal to expected " ++ show m
                else f q ps

fin :: TestCase -> [(String,Int)]
fin ((ListD _ ds):_) = (\(x,y) -> (stringData x, intData y)) <$> tuple2Data <$> ds

main = goTestVoid
    chk
    fin 
    (\_ err -> err)
    "../test_data/queue_from_stacks.tsv"