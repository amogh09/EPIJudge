{-# LANGUAGE DeriveGeneric #-}

module TestFramework.BinaryTree 
    (
        Tree (..)
    ,   binaryTreeKey
    ,   binaryTreeKey'
    ,   toZipper
    ,   goLeft
    ,   goLeft'
    ,   goRight
    ,   goRight'
    ,   goUp
    ,   goUp'
    ,   zipperKey
    ,   zipperKey'
    ,   Zipper
    ,   focus
    ,   Ancestor(..)
    ,   parent 
    ,   ancestorIsRight
    ,   isRoot
    ,   hasRightChild
    ,   hasLeftChild
    ,   emptyZipper
    ,   isEmpty
    ) where

import Data.Maybe (fromJust)
import Control.DeepSeq (NFData)
import GHC.Generics (Generic)

data Tree a = Empty | Tree a (Tree a) (Tree a) deriving (Show, Eq, Generic)

instance NFData a => NFData (Tree a)

isEmpty :: Tree a -> Bool 
isEmpty Empty = True 
isEmpty _ = False

-- Get key from a tree root safely
binaryTreeKey :: Tree a -> Maybe a 
binaryTreeKey Empty = Nothing 
binaryTreeKey (Tree x _ _) = Just x

-- Get key from a tree root unsafely
binaryTreeKey' :: Tree a -> a 
binaryTreeKey' = fromJust . binaryTreeKey

data Ancestor a = LeftAncestor a (Tree a) 
                | RightAncestor a (Tree a) deriving (Show, Eq)

type Ancestors a = [Ancestor a]

type Zipper a = (Tree a, Ancestors a)

-- Focus tree of the Zipper
focus :: Zipper a -> Tree a 
focus = fst

-- Turn a tree into a Zipper
toZipper :: Tree a -> Zipper a 
toZipper t = (t, [])

-- Go to the left subtree of current tree safely
goLeft :: Zipper a -> Maybe (Zipper a) 
goLeft (Tree x l r, bs) = Just (l, RightAncestor x r : bs)
goLeft (Empty, bs) = Nothing 

-- Go to the left subtree of current tree unsafely
goLeft' :: Zipper a -> Zipper a
goLeft' = fromJust . goLeft

-- Go to the right subtree of current tree safely
goRight :: Zipper a -> Maybe (Zipper a)
goRight (Tree x l r, bs) = Just (r, LeftAncestor x l : bs)
goRight (Empty, bs) = Nothing 

-- Go to the right subtree of current tree unsafely
goRight' :: Zipper a -> Zipper a 
goRight' = fromJust . goRight

-- Go to the parent tree of current tree safely
goUp :: Zipper a -> Maybe (Zipper a)
goUp (_, []) = Nothing
goUp (r, LeftAncestor z l : bs) = Just (Tree z l r, bs)
goUp (l, RightAncestor z r : bs) = Just (Tree z l r, bs) 

-- Go to the parent tree of current tree unsafely
goUp' :: Zipper a -> Zipper a 
goUp' = fromJust . goUp

-- Get the key of current tree in focus of the zipper safely
zipperKey :: Zipper a -> Maybe a 
zipperKey (Empty, _) = Nothing 
zipperKey (t, _) = binaryTreeKey t

-- Get the key of current tree in focus of the zipper unsafely
zipperKey' :: Zipper a -> a 
zipperKey' (t, _) = binaryTreeKey' t

-- Check if Zipper is a root
isRoot :: Zipper a -> Bool 
isRoot (_, []) = True 
isRoot _ = False

-- Empty Zipper
emptyZipper :: Zipper a
emptyZipper = (Empty, [])

hasLeftChild :: Tree a -> Bool
hasLeftChild (Tree _ Empty _) = False
hasLeftChild _ = True

hasRightChild :: Tree a -> Bool 
hasRightChild (Tree _ _ Empty) = False 
hasRightChild _ = True

ancestorIsRight :: Ancestor a -> Bool 
ancestorIsRight (RightAncestor _ _) = True 
ancestorIsRight _ = False  

-- Get Parent as ancestor safely (not Tree or Zipper, use goUp for that)
parent :: Zipper a -> Maybe (Ancestor a)
parent (_, a:_) = Just a 
parent _ = Nothing
