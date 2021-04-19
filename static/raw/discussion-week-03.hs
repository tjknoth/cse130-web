module Main where

import Prelude hiding (zip)

-- How do I use GHCI??


-- See how pattern matching works here
-- It matches from the top down
show2Bool True True = "Both True"
show2Bool False True = "One of both"
show2Bool False _ = "Both False"


result1 = (show2Bool False) False
-- A : "Both False"
-- B : "One of both"
-- C : "Both True"
-- D : Exception
-- E : ???

-- What happens if it doesn't match??
show2Bool2 True _ = "One True"
show2Bool2 False _ = "False"

result2 = show2Bool2 False True





{-
We can also use guards to include logic in which case to take
Like pattern matches, takes the first match

1. Any GUARD expression needs to produce a boolean value.

2. After listing all the guarding logic expressions you care about,
you can add an 'otherwise' guard.

3. otherwise == True

-}

representativeValue :: Int -> Int
representativeValue x
  | x == 0  = 0
  | x <= 0  = -1
  | x >= 0  = 1
  | otherwise = 99

-- What's the value of this expression?
result3 = representativeValue 3

-- What about this one?
result4 = representativeValue 0
-- A: -1
-- B: 0
-- C: 1
-- D: Exception (unhandled case)
-- E: ???


{-
recursion is built in to Haskell.

It's one of the most fundamental building blocks in functional programming.
I hope you all will feel comfortable with recursion by the end of this course.

Remember the fibonacci sequence?
1, 1, 2, 3, 5, 8, ...
Add the previous two fibonacci numbers.

What are the base numbers? What's (fib 0) and (fib 1)? Let's call them 1.
So our index and sequence goes:
index | 0 1 2 3 4 5
  seq | 1 1 2 3 5 8
-}

fib1 :: Int -> Int
fib1 n = if (n == 1 || n == 0) then 1 else (fib1 (n - 1)) + (fib1 (n - 2))

-- Ok now let's refactor this with pattern matching
-- What are the base cases? Just shout them out in the chat

fib2 :: Int -> Int
fib2 0 = 1
fib2 1 = 1
fib2 n = (fib2 (n-1)) + (fib2 (n-2))


-- We can do better, maybe we want to make sure we handle rogue input too.
-- As a SWE tip: "be conservative in what you send,
-- be liberal in what you accept" - Postel's Law / Robustness principle

fib3 n
  | n < 0 = 0
  | True = fib3 (n-1) + fib3 (n-2)
  | n == 0 = 1
  | n == 1 = 1



-- Order matters!
-- Look what happens when we switch up the order of the matches



-- Lists
-- They have two _constructors_, or ways to make a list
-- [] "nil"
-- x:xs "x cons xs"

-- We've seen other constructors before.
-- Which of these is NOT a constructor:

-- A: True
-- B: False
-- C: 0
-- D: 'a'
-- E: \x -> x






-- All constructors are functions, but not all functions are constructors
-- True :: Bool (0 - operator function)
-- [] "empty list", another 0-operator function
-- x:xs "x cons xs", a 2 argument function
--   (:) x xs  <-- Equivalent to above

-- We can pattern match on CONSTRUCTORS

-- Let's write zip
-- [1,2,3] ['a', 'b', 'c'] == [(1,'a'), (2, 'b'), (3, 'c')]
zip :: [Int] -> [Char] -> [(Int, Char)]
zip [] [] = []
zip (x:xs) [] = []
zip [] (x:xs) = []
zip (x:xs) (y:ys) = (x, y):(zip xs ys)









-- Now something a little harder.

minList :: [Int] -> Int
minList [] = error "uh oh"
minList [x] = x
-- minList (x:[]) = x
minList (x:xs) = if x < smallestInRest then x else smallestInRest
  where
      smallestInRest = minList xs

-- Where did x and xs get defined???

-- How does this work??
-- [ 1, 3, -1, 4] ~~shorthand for~~ 1:3:(-1):4:[]
-- min (1, min(3, min(-1, 4)))

-- Will this work?
-- A: Yes
-- B: No
result5 :: Int
result5 = minList [-1, 10, -7, 0]

-- Maybe we can refactor this code a bit.
-- Let's put (minList xs) in a variable.













main = print "hello world"