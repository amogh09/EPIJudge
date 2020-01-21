{-# LANGUAGE NoImplicitPrelude #-}

module TestFramework.Counter
    (
        fromList
    ,   diff
    ,   null
    ,   size
    ,   (!)
    ) where

import Prelude hiding (null)
import qualified Data.Map.Strict as M 

type Counter a = M.Map a Int

fromList :: Ord a => [a] -> Counter a 
fromList = foldr (\x -> M.insertWith (+) x 1) M.empty

diff :: Ord a => Counter a -> Counter a -> Counter a 
diff c c' = M.differenceWith f c c' 
    where f x y | x <= y = Nothing 
          f x y = Just (x - y) 

null :: Counter a -> Bool
null = M.null

size :: Counter a -> Int
size = M.size

(!) :: Ord a => Counter a -> a -> Int 
(!) = (M.!)