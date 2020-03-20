import TestFramework.TestRunner 

sunset :: [Int] -> [Int]
sunset = fmap fst . f [] . zip [0..] where 
    f xs [] = xs 
    f xs ((i,y):ys) = f ((i,y) : dropWhile ((<=y) . snd) xs) ys 

main = goTest 
    sunset
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/sunset_view.tsv"