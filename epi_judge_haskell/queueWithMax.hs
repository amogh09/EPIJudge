import TestFramework.TestRunner 

data Queue a = Queue -- TODO

empty :: Queue a 
empty = Queue -- TODO

enqueue :: (Ord a) => a -> Queue a -> Queue a 
enqueue x q = q -- TODO

dequeue :: (Ord a) => Queue a -> (a, Queue a)
dequeue q = (0,q) -- TODO

maxQ :: (Ord a) => Queue a -> a 
maxQ q = 0 -- TODO

chk :: [(String, Int)] -> Maybe String 
chk = f empty where 
    f _ [] = Nothing
    f q (("QueueWithMax", _):ps) = f empty ps 
    f q (("enqueue", x):ps) = f (enqueue x q) ps
    f q (("dequeue", x):ps) =
        let (y,q') = dequeue q 
        in  if x /= y 
                then Just $ "Dequeued " ++ show y ++ " not equal to expected " ++ show x
                else f q' ps 
    f q (("max", x):ps) = 
        let y = maxQ q
        in  if y /= x 
                then Just $ "Max " ++ show y ++ " not equal to expected " ++ show x
                else f q ps
 
fin :: TestCase -> [(String,Int)]
fin ((ListD _ ds):_) = (\(x,y) -> (stringData x, intData y)) <$> tuple2Data <$> ds

main = goTestVoid 
    chk 
    fin 
    (\_ err -> err)
    "../test_data/queue_with_max.tsv"