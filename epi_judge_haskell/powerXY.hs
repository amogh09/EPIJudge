import TestFramework.TestRunner

powerXY' :: Double -> Int -> Double
powerXY' x y = 0 -- TODO

main = goTest 
    (uncurry powerXY')
    (\(x:y:_) -> (doubleData x, intData y))
    (\(_:_:z:_) -> doubleData z)
    (\x y -> abs (x - y) <= 0.0001)
    "../test_data/power_x_y.tsv"