module TestFramework.BinaryTreeParser
    (
        makeTree
    ,   findZipper
    ,   findZipper'
    ) where

import Numeric (readDec)
import Data.Maybe (fromJust)
import TestFramework.BinaryTree

unflattenLevels :: [Maybe a] -> [[Maybe a]]
unflattenLevels [] = [] 
unflattenLevels (x:xs) = [x] : nextLevels [x] xs where 
    nextLevels [] _  = []
    nextLevels _  [] = []
    nextLevels ls rs = let (ls',rs') = nextLevelAndRest ls rs 
                       in  ls' : nextLevels ls' rs'

nextLevelAndRest :: [Maybe a] -> [Maybe a] -> ([Maybe a],[Maybe a])
nextLevelAndRest (Just _:ls) (r:r':rs) = 
    let (p,q) = nextLevelAndRest ls rs 
    in  (r:r':p,q)
nextLevelAndRest (Nothing:ls) rs = nextLevelAndRest ls rs
nextLevelAndRest [] rs = ([],rs)
nextLevelAndRest _ [r] = ([r],[])
nextLevelAndRest _  [] = ([],[]) 

joinLevels :: [[Maybe a]] -> Tree a 
joinLevels xs = 
    case f xs of
        []        -> Empty
        [Nothing] -> Empty 
        [Just t]  -> t 
    where 
    f [l]    = fmap singleton l
    f (l:ls) = joinTwoLevels l (f ls) 
    singleton Nothing  = Nothing 
    singleton (Just x) = Just $ Tree x Empty Empty

joinTwoLevels :: [Maybe a] -> [Maybe (Tree a)] -> [Maybe (Tree a)]
joinTwoLevels (Nothing:hs) ls = Nothing : joinTwoLevels hs ls 
joinTwoLevels (Just h:hs) (l:l':ls) = 
    Just (Tree h (treeFromMaybe l) (treeFromMaybe l')) : joinTwoLevels hs ls
joinTwoLevels (Just h:hs) [l] = 
    Just (Tree h (treeFromMaybe l) Empty) : joinTwoLevels hs []
joinTwoLevels (Just h:hs) []  = Just (Tree h Empty Empty) : joinTwoLevels hs []
joinTwoLevels [] [] = []

treeFromMaybe :: Maybe (Tree a) -> Tree a
treeFromMaybe Nothing  = Empty
treeFromMaybe (Just t) = t

makeTree :: [Maybe a] -> Tree a 
makeTree = joinLevels . unflattenLevels

findZipper :: (Eq a, Show a) => a -> Tree a -> Maybe (Zipper a) 
findZipper y = f . toZipper where 
    f z@(Tree x l r, bs) 
        | x == y = Just z
        | otherwise = 
            let lr = goLeft z >>= f
                rr = goRight z >>= f
            in  case (lr, rr) of 
                    (Nothing, Nothing) -> Nothing 
                    (lr, Nothing) -> lr 
                    (Nothing, rr) -> rr
                    (lr, rr)      -> lr 
    f z@(Empty, bs) = Nothing

findZipper' :: (Eq a, Show a) => a -> Tree a -> Zipper a 
findZipper' y = fromJust . findZipper y