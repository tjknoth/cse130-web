{-# LANGUAGE FlexibleInstances #-}









data Color = Red | Blue | Green
  -- deriving Eq

instance Eq Color where
    Red == Red = True
    Blue == Blue = True
    Green == Green = True
    (==) _ _ = False

-- query: Red == Red
-- 

data Tree a = 
    Empty
  | Node a (Tree a) (Tree a)
  deriving (Eq)

-- query: Node 1 Empty Empty == Node 2 Empty Empty

-- show :: (Show a) => a -> String
instance Show a => Show (Tree a) where
    show Empty = "null"
    show (Node e l r) = "(Node " ++ show e ++ " " ++ show l ++ " " ++ show r ++ ")"
    -- e :: a
    -- show e => show :: (Show a) => a -> String
    -- l :: Tree a
    -- show l => show :: (Show (Tree a)) => Tree a -> String
    -- r :: Tree a


-- define our customized show
-- instance Show a => Show (Tree a) where
--     show Empty = "null"
--     show (Node x l r) = show l ++ "," ++ show x ++ "," ++ show r

-- define our own type class
class Listable a where
    toList :: a -> [Int]

instance Listable Color where
    toList Red = [0]
    toList Blue = [1]
    toList Green = [2]

-- [Red, Blue, Green] -> [0,1,2]
mapColor :: [Color] -> [Int]
mapColor colors = concatMap toList colors -- map toList colors :: [[Int]]


-- instance Listable [Color] where
--     toList [] = []
--     toList (c:cs) = toList c ++ toList cs

instance Listable Int where
    toList x = [x]

instance Listable a => Listable [a] where
    toList [] = []
    toList (x:xs) = toList x ++ toList xs

instance Listable a => Listable (Tree a) where
    toList Empty = []
    toList (Node e l r) = toList l ++ toList e ++ toList r

-- sum :: [Int] -> Int
-- toList :: Listable a => a -> [Int]
-- sumElems :: Listable a => a -> Int
sumElems x = sum (toList x)