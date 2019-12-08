import Prelude hiding (reverse)

-- map    :: (a -> b) -> [a] -> [b]
-- filter :: (a -> Bool) -> [a] -> [a]
-- foldr  :: (a -> b -> b) -> b -> [a] -> b
-- foldl  :: (b -> a -> b) -> b -> [a] -> b

reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

reverse' :: [a] -> [a]
reverse' xs = foldl (\acc x -> x : acc) [] xs

--------------------------------------------

absValues :: [Int] -> [Int]
absValues []     = []
absValues (x:xs)
  | x < 0      = (-x):(absValues xs)
  | otherwise  =   x :(absValues xs)
  
absValues' :: [Int] -> [Int]  
absValues' xs = map (\x -> if x < 0 then -x else x) xs

--------------------------------------------

dedup :: [Int] -> [Int]
dedup [] = []
dedup (x:xs) = x:(remove x (dedup xs))
  where
    remove x [] = []
    remove x (y:ys)
      | x == y    = remove x ys
      | otherwise = y:(remove x ys) 
      
dedup' :: [Int] -> [Int]
dedup' xs = foldr (\x acc -> x:(remove' x acc)) [] xs
  where
    remove' x xs = filter (/= x) xs

    
--------------------------------------------

sort :: [Int] -> [Int]
sort [] = []
sort (x:xs) = insert x (sort xs)
  where
    insert x []     = [x]
    insert x (y:ys) = if x <= y 
                        then x:y:ys 
                        else y:(insert x ys)
                        
sort' :: [Int] -> [Int]
sort' xs = foldr (\x acc -> insert' x acc) [] xs
  where
    -- insert 3 [1,2,4]  ==> [1,2,3,4]
    -- b = [3]
    -- 4 [3]     ==> [3, 4]
    -- 2 [3, 4]  ==> [2,3,4]
    -- 1 [2,3,4] ==> [1,2,3,4]
    -- insert' x rs = foldr (\r (y:ys) -> if r > y then y:r:ys else r:y:ys) [x] rs
    insert' x rs = append (filter (< x) rs) (x : (filter (>= x) rs))
    append xs ys = foldr (:) ys xs
 




