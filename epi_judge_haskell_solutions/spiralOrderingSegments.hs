import TestFramework.TestRunner 
import qualified Data.Vector as V
import qualified Data.Set as S

next :: Int -> (Int,Int) -> (Int,Int)
next 0 (i,j) = (i,j+1)
next 1 (i,j) = (i+1,j)
next 2 (i,j) = (i,j-1)
next 3 (i,j) = (i-1,j)

isValidPos :: Int -> S.Set (Int,Int) -> (Int,Int) -> Bool 
isValidPos n vs (i,j) 
    | i < 0 || i >=n = False 
    | j < 0 || j >=n = False 
    | (i,j) `S.member` vs = False 
    | otherwise = True

spiralOrdering :: [[a]] -> [a]
spiralOrdering table = f 0 S.empty 0 (0,0) where 
    vtable = V.fromList <$> V.fromList table 
    n = V.length vtable
    n2 = n*n
    f c visited d (i,j)
        | c == n2 = [] 
        | otherwise = 
            let (i',j')   = next d (i,j)
                visited'  = S.insert (i,j) visited
                v         = vtable V.! i V.! j
                d'        = (d+1) `mod` 4
                (i'',j'') = next d' (i,j) 
            in  if isValidPos n visited (i',j')
                    then v : f (c+1) visited' d (i',j')
                    else v : f (c+1) visited' d' (i'',j'')

main = goTest 
    spiralOrdering
    (listOfIntList . head)
    (intList . head . tail)
    (==)
    "../test_data/spiral_ordering_segments.tsv"