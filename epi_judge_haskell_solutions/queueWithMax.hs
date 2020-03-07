import TestFramework.TestRunner 

data Stack a = Stack [a] [a] deriving Show

emptyStack :: Stack a 
emptyStack = Stack [] [] 

isEmptyStack :: Stack a -> Bool
isEmptyStack (Stack [] []) = True 
isEmptyStack _ = False

pushStack :: (Ord a) => a -> Stack a -> Stack a 
pushStack x (Stack [] []) = Stack [x] [x] 
pushStack x (Stack xs (m:ms))
    | x >= m = Stack (x:xs) (x:m:ms)
    | otherwise = Stack (x:xs) (m:ms)

popStack :: (Eq a) => Stack a -> (a,Stack a)
popStack (Stack (x:xs) (m:ms)) 
    | x == m = (x, Stack xs ms) 
    | otherwise = (x, Stack xs (m:ms))

stackMax :: Stack a -> a 
stackMax (Stack _ (m:_)) = m

stackFromList :: (Ord a) => [a] -> Stack a
stackFromList = foldr pushStack emptyStack where 

data Queue a = Queue (Stack a) (Stack a) deriving Show

empty :: Queue a 
empty = Queue emptyStack emptyStack

enqueue :: (Ord a) => a -> Queue a -> Queue a 
enqueue x (Queue en de) = Queue (pushStack x en) de 

dequeue :: (Ord a) => Queue a -> (a, Queue a)
dequeue (Queue en@(Stack xs _) de)
    | isEmptyStack de = dequeue (Queue emptyStack (stackFromList . reverse $ xs))
    | otherwise = let (x,de') = popStack de in (x, Queue en de')

maxQ :: (Ord a) => Queue a -> a 
maxQ (Queue en de)
    | isEmptyStack en = stackMax de 
    | isEmptyStack de = stackMax en 
    | otherwise = max (stackMax en) (stackMax de)

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