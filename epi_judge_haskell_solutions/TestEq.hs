module TestEq (TestEqCl, eq) where 

import EPIPrelude

class TestEqCl a where 
    eq :: a -> a -> Bool

instance TestEqCl Int where 
    eq = (==)

instance TestEqCl Integer where 
    eq = (==)

instance TestEqCl Char where
    eq = (==)

instance TestEqCl a => TestEqCl [a] where 
    []     `eq` [] = True
    []     `eq` _  = False
    _      `eq` [] = False 
    (x:xs) `eq` (y:ys)
        | x `eq` y  = xs `eq` ys 
        | otherwise = False

instance TestEqCl Double where 
    x `eq` y = abs (x - y) <= 0.0000001