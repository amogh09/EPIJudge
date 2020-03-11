module TestFramework.BinaryTree 
    (
        Tree (..)
    ,   binaryTreeKey
    ,   binaryTreeKey'
    ,   toZipper
    ,   goLeft
    ,   goRight
    ,   goUp
    ,   goUp'
    ,   zipperKey
    ,   zipperKey'
    ,   Zipper
    ) where

import Data.Maybe (fromJust)

data Tree a = Empty | Tree a (Tree a) (Tree a) deriving (Show)

-- Get key from a tree root safely
binaryTreeKey :: Tree a -> Maybe a 
binaryTreeKey Empty = Nothing 
binaryTreeKey (Tree x _ _) = Just x

-- Get key from a tree root unsafely
binaryTreeKey' :: Tree a -> a 
binaryTreeKey' = fromJust . binaryTreeKey

data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show)

type BreadCrumbs a = [Crumb a]

type Zipper a = (Tree a, BreadCrumbs a)

-- Turn a tree into a Zipper
toZipper :: Tree a -> Zipper a 
toZipper t = (t, [])

-- Go to the left subtree of current tree safely
goLeft :: Zipper a -> Maybe (Zipper a) 
goLeft (Tree x l r, bs) = Just (l, LeftCrumb x r : bs)
goLeft (Empty, bs) = Nothing 

-- Go to the right subtree of current tree safely
goRight :: Zipper a -> Maybe (Zipper a)
goRight (Tree x l r, bs) = Just (r, RightCrumb x l : bs)
goRight (Empty, bs) = Nothing 

-- Go to the parent tree of current tree safely
goUp :: Zipper a -> Maybe (Zipper a)
goUp (_, []) = Nothing
goUp (l, LeftCrumb z r : bs) = Just (Tree z l r, bs)
goUp (r, RightCrumb z l : bs) = Just (Tree z l r, bs) 

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