import TestFramework.TestRunner 

replaceAndRemove :: String -> String 
replaceAndRemove [] = [] 
replaceAndRemove ('a':xs) =  "dd" ++ replaceAndRemove xs 
replaceAndRemove ('b':xs) = replaceAndRemove xs
replaceAndRemove (x:xs)   = x : replaceAndRemove xs

main = goTest 
    replaceAndRemove
    (concat . textList . head . tail)
    (concat . textList . (!!2))
    (==)
    "../test_data/replace_and_remove.tsv"