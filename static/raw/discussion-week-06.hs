import Prelude hiding (reverse, last, map, filter)


reverse :: [a] -> [a]
reverse xs = foldl f base xs
    where
        f a x  = x : a
        base   = []

last :: [a] -> a
last []     = error "last: empty list"
last (x:xs) = foldl f base xs
    where
        f _ x = x
        base  = x

append :: [a] -> [a] -> [a]
append xs ys = foldr f base l
    where
        f x a = x : a
        base  = ys
        l     = xs

map :: (a -> b) -> [a] -> [b]
map f xs = foldr fold_fun base xs
    where
        fold_fun x a = f x : a
        base         = []

filter :: (a -> Bool) -> [a] -> [a]
filter p xs = foldr f base xs
    where
        f x a = if p x then x : a else a
        base  = []
