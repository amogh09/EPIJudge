import TestFramework.TestRunner 

data Stack a = Stack [a] [a]

empty :: Stack a 
empty = Stack [] [] 

isEmpty :: Stack a -> Bool
isEmpty (Stack [] []) = True 
isEmpty _ = False

push :: (Ord a) => a -> Stack a -> Stack a 
push x (Stack [] []) = Stack [x] [x] 
push x (Stack xs (m:ms))
    | x >= m = Stack (x:xs) (x:m:ms)
    | otherwise = Stack (x:xs) (m:ms)

pop :: (Eq a) => Stack a -> (a,Stack a)
pop (Stack (x:xs) (m:ms)) 
    | x == m = (x, Stack xs ms) 
    | otherwise = (x, Stack xs (m:ms))

stackMax :: Stack a -> a 
stackMax (Stack _ (m:_)) = m

wrapper :: [(String,Int)] -> Maybe String 
wrapper = f empty where 
    f s (("Stack",0):ps) = f empty ps 
    f s (("empty",0):ps) = 
        if isEmpty s 
            then Just "Expected empty but is not empty"  
            else f s ps
    f s (("empty",1):ps) = 
        if isEmpty s 
            then f s ps
            else Just "Expected not empty but is empty" 
    f s (("push",x):ps) = f (push x s) ps 
    f s (("pop",x):ps) = 
        let (y,s') = pop s
        in  if x /= y 
                then Just $ "Popped " ++ show y ++ " not equal to expected " ++ show x
                else f s' ps
    f s (("max",x):ps) = 
        let y = stackMax s 
        in  if x /= y
                then Just $ "Returned max " ++ show y ++ " not equal to expected " ++ show x
                else f s ps
    f _ [] = Nothing

fin :: TestCase -> [(String,Int)]
fin ((ListD _ ds):_) = (\(x,y) -> (stringData x, intData y)) <$> tuple2Data <$> ds

main = goTestVoid 
    wrapper
    fin 
    (\_ err -> err)
    "../test_data/stack_with_max.tsv"