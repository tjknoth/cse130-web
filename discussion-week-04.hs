module Main where

import Prelude hiding (True,False, Bool)

data Color = Red | Blue | Green

data Bool = True | False

data Foo = Color Color | Bool

data Bar = Bar { color :: Color, bool :: Bool }

myFoo = Color Red

myBar = Bar {color=Blue, bool=False}
myBar2 = Bar Green True


-- MyList: (Int, Bool) : (Int, Bool) : []

data MyList = EndList | ListNode (Int, Bool) MyList

myExampleList =
    ListNode (1, False)
        (ListNode (2, True) EndList)


-- Define Length
myLength EndList = 0
myLength (ListNode _ next) = 1 + myLength next
-- Define Append








data Expr
    = Number Int
    | Add Expr Expr
    | Mul Expr Expr
-- What kind of types are used here?
-- What else might we want to do?
-- Sum / Product / Recursive ?

-- What are some example expressions?
myexpr1 = Number 1

myExp2 = Add (Number 2) (Number 3)

myexpr3 = Mul (Number 3) (Number 4)




-- How do I write: (3 + (4 * 5)) + 1
-- Following the usual order of arithmetic
myExpr4 = Add subexp2 (Number 1)
    where
        subexp1 = Mul (Number 4) (Number 5)
        subexp2 = Add (Number 3) subexp1

myExpr4' = Add
    (Add
        (Number 3)
        (Mul
            (Number 4)
            (Number 5)))
    (Number 1)




{-
data Expr
    = Number Int
    | Add Expr Expr
    | Mul Expr Expr
-}

-- TODO: evalExpr
evalExpr :: Expr -> Int
evalExpr (Number n) = n
evalExpr (Add lexpr rexpr) = (evalExpr lexpr) + (evalExpr rexpr)
evalExpr (Mul lexpr rexpr) = (evalExpr lexpr) * (evalExpr rexpr)









-- TODO: Fibonacci Sequence as datatype























-- data Fib = Base | Next Fib

-- >>> evalFib (Next (Next (Next (Next Base))))
-- 5
-- evalFib Base = 1
-- evalFib (Next Base) = 1
-- evalFib (Next (Next f)) = evalFib (Next f) + evalFib f

main = print "Hello World"
