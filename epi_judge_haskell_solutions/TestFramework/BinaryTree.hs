module TestFramework.BinaryTree (makeTree, Tree(..), binaryTreeKey) where

import Data.Maybe (fromJust)
import Numeric (readDec)

data Tree a = Empty | Tree a (Tree a) (Tree a) deriving (Show)

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

binaryTreeKey :: Tree a -> Maybe a 
binaryTreeKey Empty = Nothing 
binaryTreeKey (Tree x _ _) = Just x