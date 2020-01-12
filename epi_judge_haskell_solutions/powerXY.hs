import TestFramework.TestRunner

powerXY' :: Double -> Int -> Double
powerXY' x y
    | y < 0 = powerXY' (1/x) (-y) 
    | otherwise = f x y 1 where 
        f x 0 r = r 
        f x y r = let r' = if odd y then r*x else r 
                  in  f (x*x) (y `div` 2) r'

main = goTest 
    (uncurry powerXY')
    (\(x:y:_) -> (doubleData x, intData y))
    (\(_:_:z:_) -> doubleData z)
    (\x y -> abs (x - y) <= 0.0001)
    "../test_data/power_x_y.tsv"