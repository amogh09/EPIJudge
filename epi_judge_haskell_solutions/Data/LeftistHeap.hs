module Data.LeftistHeap 
    (
        getMin
    ,   delMin
    ,   insert
    ,   merge
    ,   singleton
    ,   toList
    ,   fromList
    ,   isEmpty
    ,   empty
    ,   LHeap
    ) where 

import Data.Maybe (fromJust)

data LHeap k v = LHeap {
        _rank    :: Int 
    ,   _key     :: k 
    ,   _value   :: v 
    ,   _left    :: LHeap k v 
    ,   _right   :: LHeap k v          
    } | Empty deriving (Show)

rank :: LHeap k v -> Int 
rank Empty = 0 
rank h = _rank h

empty :: LHeap k v 
empty = Empty

isEmpty :: LHeap k v -> Bool 
isEmpty Empty = True 
isEmpty _ = False

singleton :: k -> v -> LHeap k v 
singleton k v = LHeap 1 k v Empty Empty

merge :: (Ord k) => LHeap k v -> LHeap k v -> LHeap k v
merge Empty t2 = t2 
merge t1 Empty = t1 
merge t1 t2 | _key t1 > _key t2 = merge t2 t1 
merge (LHeap w k v l r) t2 = preserveRank $ LHeap w k v l (merge r t2)

preserveRank :: LHeap k v -> LHeap k v 
preserveRank (LHeap w k v l r) | rank l < rank r = preserveRank $ LHeap w k v r l
preserveRank (LHeap _ k v l r) = LHeap (rank r + 1) k v l r

insert :: (Ord k) => k -> v -> LHeap k v -> LHeap k v 
insert k v = merge (singleton k v)

delMin :: (Ord k) => LHeap k v -> LHeap k v
delMin Empty = Empty
delMin (LHeap _ _ _ l r) = l `merge` r

getMin :: LHeap k v -> Maybe (k,v) 
getMin Empty = Nothing
getMin (LHeap _ k v _ _) = Just (k,v)

treeFold1 :: (a -> a -> a) -> [a] -> a
treeFold1 f [x] = x
treeFold1 f xs = treeFold1 f . pairs $ xs where 
    pairs (x:x':xs) = f x x' : pairs xs 
    pairs [x] = [x] 
    pairs [] = []

fromList :: (Ord k) => [(k,v)] -> LHeap k v 
fromList = treeFold1 merge . fmap (uncurry singleton)

toList :: (Ord k) => LHeap k v -> [(k,v)]
toList Empty = []
toList h = (_key h, _value h) : toList (delMin h) 