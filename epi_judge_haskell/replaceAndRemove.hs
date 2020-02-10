import TestFramework.TestRunner 

replaceAndRemove :: String -> String 
replaceAndRemove xs = xs -- TODO

main = goTest 
    replaceAndRemove
    (concat . textList . head . tail)
    (concat . textList . (!!2))
    (==)
    "../test_data/replace_and_remove.tsv"