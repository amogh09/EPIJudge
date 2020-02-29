import TestFramework.TestRunner 

data Stack a = Stack -- TODO

empty :: Stack a 
empty = Stack -- TODO

isEmpty :: Stack a -> Bool
isEmpty s = True -- TODO

push :: (Ord a) => a -> Stack a -> Stack a 
push x s = s -- TODO

pop :: (Eq a) => Stack a -> (a,Stack a)
pop s = s -- TODO

stackMax :: Stack a -> a 
stackMax s = x -- TODO

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