myReverse :: [a] -> [a]
myReverse xs = foldl f base xs
  where
    f a x = x:a
    base = []


myLast :: [a] -> a
myLast [] = error "last: empty list"
myLast (x:xs) = foldl f base xs
  where
    f a y = y
    base = x


myAppend :: [a] -> [a] -> [a]
-- foldr (:) ys xs
myAppend xs ys = foldr f base l
  where
    f x a = x:a
    base = ys
    l = xs


myMap :: (a -> b) -> [a] -> [b]
myMap f xs = foldr fold_fun base xs
  where
    fold_fun x a = f x : a
    base = []


myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p xs = foldr f base xs
  where
    f x a = if p x then x:a else a
    base = []