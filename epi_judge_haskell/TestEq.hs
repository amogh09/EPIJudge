module TestEq (TestEq) where 

import EPIPrelude

class TestEq a where 
    eq :: a -> a -> Bool

instance TestEq Int where 
    eq = (==)

instance TestEq Integer where 
    eq = (==)

instance TestEq String where
    eq = (==)

instance TestEq Double where 
    x `eq` y = abs (x - y) <= 0.0000001