import TestFramework.TestRunner 

headOrDef :: a -> [a] -> a 
headOrDef z (x:xs) = x 
headOrDef z [] = z 

safeTail :: [a] -> [a]
safeTail [] = [] 
safeTail (x:xs) = xs 

add :: [Int] -> [Int] -> [Int]
add xs ys = reverse $ f 0 (reverse xs) (reverse ys) where  
    f 1 [] [] = [1]
    f 0 [] [] = []   
    f c xs ys = 
        let x = headOrDef 0 xs 
            y = headOrDef 0 ys 
            (c',s) = (x+y+c) `quotRem` 10 
        in  s : f c' (safeTail xs) (safeTail ys)

mulSingle :: Int -> [Int] -> [Int]
mulSingle x ys = reverse $ f 0 (reverse ys) where 
    f 0 [] = [] 
    f c [] = [c]
    f c (y:ys) = let (c',s) = (c + x*y) `quotRem` 10 
                 in  s : f c' ys 

negateFst :: [Int] -> [Int]
negateFst [] = [] 
negateFst (x:xs) = (-x:xs)

multiply :: [Int] -> [Int] -> [Int]
multiply (x:xs) ys | x < 0 = negateFst $ multiply (-x:xs) ys
multiply xs (y:ys) | y < 0 = negateFst $ multiply xs (-y:ys)
multiply [0] _ = [0]
multiply _ [0] = [0]
multiply xs ys = foldl1 add . fmap f . zip [0..] . reverse $ ys where 
    f (i,y) = mulSingle y xs ++ replicate i 0 

main = goTest 
    (uncurry multiply)
    (listToTuple2 . fmap intList . take 2)
    (intList . (!! 2))
    (==)
    "../test_data/int_as_array_multiply.tsv"