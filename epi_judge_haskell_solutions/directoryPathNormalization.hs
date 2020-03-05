import TestFramework.TestRunner 
import Data.List (intersperse,isPrefixOf)

splitOn :: (Eq a) => a -> [a] -> [[a]]
splitOn _ [] = []
splitOn x [y]
    | x == y = [[]]
    | otherwise = [[y]]
splitOn x (y:ys)
    | x == y = 
        let (r:rs) = splitOn x ys 
        in  case r of 
                [] -> r:rs
                r  -> []:r:rs
    | otherwise = let (r:rs) = splitOn x ys in (y:r):rs

normalize :: String -> String 
normalize [] = []
normalize ('/':xs) = '/' : normalizeNonRoot xs
normalize xs = normalizeNonRoot xs

normalizeNonRoot :: String -> String
normalizeNonRoot = concat . intersperse "/" . reverse . f [] . splitOn '/'
    where
        f [] ("":ps)          = f [] ps 
        f [] ("..":ps)        = f [".."] ps 
        f ("..":rs) ("..":ps) = f ("..":"..":rs) ps
        f (r:rs) ("..":ps)    = f rs ps 
        f rs (".":ps)         = f rs ps 
        f rs (p:ps)           = f (p:rs) ps 
        f rs []               = rs

main = goTest 
    normalize
    (stringData . head)
    (stringData . head . tail)
    (==)
    "../test_data/directory_path_normalization.tsv"