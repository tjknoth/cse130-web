--Discussion section 10.22.21
--(Recursive) algebraic data types

import Debug.Trace

-- Lets define a language of arithmetic expressions:

-- 1 + 2
-- 2 - 1
-- 3 * (1 + 2)
-- 5 / 2
-- etc.

-- TODO
data Expr  
  = Num Double  -- TODO
  deriving Show







-- Now, let's write an interpreter:
-- eval (Times (Plus (Num 3) (Num 2)) (Num -3)) = -15
eval :: Expr -> Double 
eval e = undefined









-- Now, let's handle errors.
-- What should happen if we divide by zero? 

data MaybeDouble
  = OK Double
  | Err
  deriving Show

eval' :: Expr -> MaybeDouble
eval' e = undefined







-- More practice problems:

-- count 1 [1, 2, 1] = 2
-- count 1 [2, 3] = 0
count :: Int -> [Int] -> [Int]
count = undefined --TODO

-- reverse a list
reverse :: [Int] -> [Int]
reverse = undefined --TODO

-- replicate 2 [1, 2] = [1, 1, 2, 2]
replicate :: Int -> [Int] -> [Int]
replicate = undefined --TODO

-- compress [1, 2, 3] = [1, 2, 3]
-- compress [1, 1, 2, 3, 3] = [1, 2, 3]
-- compress [1, 2, 1] = [1, 2, 1]
compress :: [Int] -> [Int]
compress = undefined --TODO



-- Some tree types

-- Binary tree
data BTree
  = BEmpty
  | BNode Int BTree BTree
  deriving Show

-- Can we define a tree with an arbitrary number of child nodes?
data Tree = Empty -- TODO
  deriving Show

bflatten :: BTree -> [Int]
bflatten = undefined -- TODO

tflatten :: Tree -> Int
tflatten = undefined --TODO


-- A simple language of boolean expressions:

-- a && b
-- (a && b} || a
-- !a
-- etc.


data BoolExpr 
  = Var String -- TODO: other cases
  deriving Show  

-- boolEval [("a", True)] (Var "a") = True
-- boolEval [("a", True), ("b", False)] (And (Var "b") (Var "a")) = False
boolEval :: [(String, Bool)] -> BoolExpr -> Bool
boolEval = undefined --TODO





-- These are hard!

-- truthTable2: given an expression of two variables (the first two arguments),
--   return a list of triples containing (value_of_a, value_of_b, value_of_expr)
--
-- truthTable2 "a" "b" (And (Var "a") (Or (Var "a") (Var "b")))
--   = [(True, True, True), (True, False, True), (False, True, False)
--      , (False, False, False)]
truthTable2 :: String -> String -> BoolExpr -> [(Bool, Bool, Bool)]
truthTable2 = undefined --TODO

-- Generalize the above to expressions with an arbitrary # of variables
truthTable :: [String] -> BoolExpr -> [([(String, Bool)], Bool)]
truthTable = undefined --TODO
