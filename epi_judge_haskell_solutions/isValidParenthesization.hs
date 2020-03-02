import TestFramework.TestRunner 

isOpen :: Char -> Bool 
isOpen '(' = True 
isOpen '[' = True 
isOpen '{' = True 
isOpen _ = False 

isClose :: Char -> Bool 
isClose ')' = True 
isClose ']' = True 
isClose '}' = True 
isClose _ = False

validParenthesis :: String -> Bool
validParenthesis = f [] where 
    f ('(':ys) (')':xs) = f ys xs 
    f ('{':ys) ('}':xs) = f ys xs 
    f ('[':ys) (']':xs) = f ys xs 
    f ys (x:xs) 
        | isClose x = False
        | isOpen x  = f (x:ys) xs
        | otherwise = f ys xs
    f [] [] = True
    f _  [] = False

main = goTest
    validParenthesis
    (stringData . head)
    (boolData . head . tail)
    (==)
    "../test_data/is_valid_parenthesization.tsv"