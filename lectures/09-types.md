---
title: Well-Typed Programs Don't Go Wrong
date: 2018-05-21
headerImg: books.jpg
---

## Plan for this week


**Past month:**

How do we *implement* a tiny functional language?

  1. *Interpreter:* how do we *evaluate* a program given its AST?
  
  3. *Parser:* how do we convert strings to ASTs?
  
  2. *REPL:* how do we write an app that repeatedly evaluates expressions?
  

**This week:**

How do we *reason* about programs mathematically?

  1. *Operational semantics:* formalizing how programs evaluate

  2. *Type system:* formalizing which expressions have which types
  
  3. *Type soundness:* proving that well-typed programs behave well at run time
  
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Type Checking: Goal

Consider a simplified version of Nano without:

  - `let`-bindings
  - subtraction, multiplication, ...
  - booleans
  - recursion
  
<br>
<br>

**Expressions:**

```haskell
e ::= n        -- numeral
    | x        -- variable
    | e1 + e2  -- addition
    | \x -> e  -- abstraction
    | e1 e2    -- application        
```

<br>
<br>

Can you give me examples of Nano programs that crash? Run forever?

<br>

The **goal** of type checking is to *detect* and *reject* such programs *before* run.

<br>
<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

Which one of these Nano programs is well-typed (in your opinion)?

**(A)** `x + 1`

**(B)** `1 2`

**(C)** `(\x -> x + 1) (\y -> y)`

**(D)** `(\f y -> f y) (\x -> x + 1) 5`

**(E)** `(\x -> x x) (\y -> y y)`

<br>

(I) final

    *Answer:* **D**.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

*(A)* `x + 1` 

*Type error:* Unbound variable `x`

*(B)* `1 2` 

*Type error:* LHS of application should be of type `Int -> T2`

*(C)* `(\x -> x + 1) (\y -> y)` 

*Type error:* RHS of application should be of type `Int`

*(D)* `(\f y -> f y) (\x -> x + 1) 5 :: Int`

*(E)* `(\x -> x x) (\y -> y y)`

*Type error:* `x` cannot be both `T1 -> T2` and `T1`

<br>
<br>

**At run time:**

- Programs A, B, C *crash*
- Program E *runs forever*
- Program D *evaluates to a value* (6)

<br>
<br>

Can we **prove** that *all* well-typed programs *always* evaluate to a value?
  
  - do not crash?
  - do not run forever?
  
<br>
<br>

**Yes we can!**

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Outline

1. **Operational Semantics**
2. Type System
3. Type Soundness
  
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


## Nano: Operational Semantics

**Operational semantics** defines how to evaluate a program

  - Like our `eval :: Env -> Expr -> Value`, but written in math

<br>

Let's define an *evaluation relation* `E ; e ==> v`

  - Informal meaning: "expression `e` evaluates to value `v` in environment `E`"

<br>

First we need to define *values* and *environments*:

<br>
<br>

**Values:**

```haskell
v ::= n         -- numeral
    | <E, x, e> -- closure
```

<br>
<br>

**Environments:**

```haskell
E ::= []        -- empty
    | x := v, E -- value binding and rest
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Inference Rules

In PL, we define relations formally using *inference rules* of the form:

```haskell
            premise_1 ... premise_n
[Rule-Name] -----------------------
                  conclusion
``` 

Meaning: 

    - If `premise_1` is true and ... and `premise_n` is true
    - then `conclusion` is also true.
    
Or alternatively:

    - In order to prove `conclusion`
    - you have to prove `premise_1` and ... and `premise_n`.
    
Rules with no premises are called **axioms**

    - Conclusion is *always* true

<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Nano Evaluation Rules

```haskell
-- A numeral always evaluates to itself:

[E-Num] -------------
        E ; n  ==>  n
         
-- A variable x evaluates to v in an env where it is bound to v:
         
[E-Var] --------------------
        (x:=v,E) ; x  ==>  v

-- If both sides of addition evaluate to numerals,
-- then addition evaluated to their sum:

          E ; e1 ==> n1   E ; e2 ==> n2   n == n1 + n2
[E-Add]   --------------------------------------------
                      E ; (e1 + e2) ==> n

-- A lambda abstraction always evaluates to a closure:
          
[E-Lam]   ---------------------------
          E ; (\x -> e) ==> <E, x, e>
          
-- If LHS evaluates to a closure, RHS evaluates to v2,
-- and the body of the closure evaluates to v 
-- in the closure environment extended with binding of formal to v2,
-- then the application of LHS to RHS evaluates to v:
       
        E ; e1 ==> <E', x, e>   E ; e2 ==> v2   (x:=v2,E') ; e ==> v
[E-App] ---------------------------------------------------------------
                               E ; (e1 e2) ==> v
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Derivations

A **derivation** of `E ; e ==> v` is a *tree* build from inference rules where
  
  - the root is `E ; e ==> v`
  - leaves are axioms
  
<br>
<br>  
  
For example, this is the derivation of `([x:=5], x + 1)  ==>  6`  

```haskell
        
[E-Var] ----------------  [E-Num]---------------
        [x:=5] ; x ==> 5        [x:=5] ; 1 ==> 1   6 == 1 + 5
[E-Add] --------------------------------------------------
                      [x:=5] ; (x + 1)  ==>  6
```

<br>
<br>

Meaning:

- Our goal is to prove that `[x:=5] ; (x + 1) ==> 6`.
- This relation matches the *conclusion* of rule `[E-Add]`.
- Hence we can construct its derivation using `[E-Add]`, we only need to prove its premises.
- The first premise is `[x:=5] ; x ==> n1`: 
    - This relation matches the conclusion of rule `[E-Var]`.
    - Hence we can construct its derivation using `[E-Var]` with `n1 == 5`.
    - `[E-Var]` has no premises, hence this sub-derivation is complete.
- The second premise is `[x:=5] ; 1 ==> n2`:
    - This relation matches the conclusion of rule `[E-Num]`.
    - Hence we can construct its derivation using `[E-Num]` with `n2 == 1`.
    - `[E-Num]` has no premises, hence this sub-derivation is complete.
- Since `6 == 5 + 1`, we conclude `[x:=5] ; (x + 1) ==> 6` by `[E-Add]`.


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

What is the correct derivation of `[] ; (1 + 2) + 3  ==>  6`?

**(A)**
```
                6==1+2+3
[E-Add] ------------------------
        [] ; (1 + 2) + 3  ==>  6
```

**(B)**
```
        [E-Num]      [E-Num]     [E-Num]
       ----------  ----------  ----------
       [];1 ==> 1  [];2 ==> 2  [];3 ==> 3  6==1+2+3
[E-Add]---------------------------------------------
                 [] ; (1 + 2) + 3  ==>  6
```

**(C)** 
```
        [E-Num]      [E-Num]
       ----------  ----------
       [];1 ==> 1  [];2 ==> 2   3==1+2      [E-Num]
[E-Add]--------------------------------   ----------
              [];(1 + 2) ==> 3            [];3 ==> 3   6==3+3
[E-Add]------------------------------------------------------
                 [] ; (1 + 2) + 3  ==>  6
```

<br>

(I) final

    *Answer:* **C**.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


## QUIZ

Which of the following relations have a derivation for *some* value `v`?

**(A)** `[] ; x + 1  ==>  v`

**(B)** `[] ; 1 2  ==>  v`

**(C)** `[] ; (\f y -> f y) (\x -> x + 1)  ==>  v`

**(D)** `[] ; (\x -> x x) (\y -> y y)  ==>  v`

<br>

(I) final

    *Answer:* **C**.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

*(A)*

```
    -- NO RULE MATCHES!!!       
        --------------
        [] ; x ==> n1   ...   ...
[E-Add]-----------------------------
           [] ; x + 1  ==>  v
```

*(B)*

```
    -- NO RULE MATCHES!!!       
       ------------------
       [] ; 1 ==> <E,x,e>   ...   ... 
[E-App]------------------------------
                 [] ; 1 2  ==>  v
```

*(C)*

```
                                       [E-Lam]
                  ------------------------------------------------------
                  [f:=<[],x,x+1>] ; \y->f y ==> <[f:=<[],x,x+1>],y,f y> 
                                                                       ^
               [E-Lam]                            [E-Lam]              |
-----------------------------------   -------------------------------  |
[];(\f y -> f y) ==> <[],f,\y->f y>   [];(\x -> x + 1) ==> <[],x,x+1>  |
[E-App]-----------------------------------------------------------------
                [] ; (\f y -> f y) (\x -> x + 1)  ==>  v
```

*(D)*

```
                    -- X2                            AND SO ON!
[E-Var] ----------------------------------  ----------------------------
        [x:=<[],x,x x>] ; x ==> <[],x,x x>  [x:=<[],x,x x>] ; x x ==> v                                                        
             [E-App]------------------------------------------------
                            [x:=<[],x,x x>] ; x x ==> v
                  --  X2     
[E-Lam]-----------------------------
       [];(\x -> x x) ==> <[],x,x x>         
[E-App]----------------------------------------------------------
       [] ; (\x -> x x) (\x -> x x)  ==>  v
```


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Evaluation Results

For any pair `E ; e` one of the following is true:

1. We can build a derivation `E ; e ==> v` for some `v`

    - We say that `e` **evaluates to a value** in `E`
    - Example: `[x:=5] ; (x + 1) ==> 6`
   
2. We try to build a derivation, but at some point no rule applies

    - We say that `e` **gets stuck** in `E` (corresponds to *runtime error* / *crash* in `eval`)
    - Example: `[] ; (x + 1)`
   
3. We try to build a derivation, but it just goes on forever

    - We say that `e` **diverges** in `E` (corresponds to *nontermination* in `eval`)
    - Example: `[] ; (\x -> x x) (\y -> y y)`
  
<br>
<br>  

In cases 2 and 3 we say that `e` **goes wrong** in `E`.
    
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Outline

1. Operational Semantics [done]
2. **Type System**
3. Type Soundness  



<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Type System for Nano

A **type system** defines what types we can assign to an expression

<br>

Let's try to define a *typing relation* `e :: T`

  - Informal meaning: "expression `e` has type `T`"

<br>

First we need to define what *types* look like:

<br>
<br>

**Types:**

```haskell
T ::= Int       -- integers
    | T1 -> T2  -- function types
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


### Typing Rules: Take I

We define the typing relation using *inference rules*:

```haskell
-- A numeral always has type Int:
[T-Num]  n :: Int

-- Addition has type Int, provided both sides have type Int:
         e1 :: Int    e2 :: Int
[T-Add]  ----------------------
            e1 + e2 :: Int
      
-- Variable has type ???      
[T-Var]   x :: ???
```

<br>

What is the type of a variable?

<br>
<br>
<br>
<br>

Reminder: to *evaluate* a variable we save its *value* in the *environment*

So: to *type* a variable we have to save its *type* in the *type environment*

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Type Environment

An expression has a type in a given **type environment** (also called **context**),
which maps all its *free variables* to their *types*

**Contexts:**

```haskell
G ::= []      -- empty
    | x:T, G  -- type binding and rest
```

<br>

Our *typing relation* should include the context `G |- e :: T`:

  - Informal meaning: "expression `e` has type `T` in context `G`"

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Typing rules

```haskell
-- A numeral always has type Int:
[T-Num] -------------
        G |- n :: Int

-- A variable has type T in a context that binds it to T:
[T-Var] ----------------
        x:T, G |- x :: T

-- Addition has type Int, provided both sides have type Int: 
         G |- e1 :: Int   G |- e2 :: Int
[T-Add]  -------------------------------
               G |- e1 + e2 :: Int

-- Lambda abstraction has type T1 -> T2 provided
-- its body has type T2 in a context where formal is bound to T1:
          x:T1, G |- e :: T2
[T-Lam] ------------------------
        G |- \x -> e :: T1 -> T2
        
-- Application has type T2 provided there exists T1
-- such that the LHS has type T1 -> T2 and RHS has type T1
        G |- e1 :: T1 -> T2   G |- e2 :: T1
[T-App] -----------------------------------
                 G |- e1 e2 :: T2
```
<br>

An expression `e` **has type** `T` in `G` if we can derive `G |- e :: T` using these rules

An expression `e` is **well-typed** in `G` if we can derive `G |- e :: T` for some type `T`

  - and **ill-typed** otherwise

<br>
<br>
<br>
<br>
<br>

For example, this is the derivation of `[x:=5] |- x + 1 :: Int`  

```haskell
        
[T-Var] -----------------  [T-Num]----------------
        [x:=5] ; x :: Int        [x:=5] ; 1 :: Int
[T-Add] ------------------------------------------
                  [x:=5] |- x + 1 :: Int
```

<br>
<br>

Meaning:

- Our goal is to prove that `[x:=5] |- x + 1 :: Int`.
- This relation matches the *conclusion* of rule `[T-Add]`.
- Hence we can construct its derivation using `[T-Add]`, we only need to prove its premises.
- The first premise is `[x:=5] ; x :: Int`: 
    - This relation matches the conclusion of rule `[T-Var]`.
    - `[T-Var]` has no premises, hence this sub-derivation is complete.
- The second premise is `[x:=5] ; 1 :: Int`:
    - This relation matches the conclusion of rule `[T-Num]`.
    - `[T-Num]` has no premises, hence this sub-derivation is complete.
    
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

What is the correct derivation of `[] |- (\x -> x) 2 :: Int`?

**(A)**
```
[T-Num] ------------------------
             [] |- 2 :: Int
[T-App] ------------------------
        [] |- (\x -> x) 2 :: Int
```

**(B)**
```
[T-Num] --------------------
        [x := 2] |- 2 :: Int        
[T-Var] --------------------
        [x := 2] |- x :: Int
[T-App] ------------------------
        [] |- (\x -> x) 2 :: Int
```

**(C)** 
```
[T-Var] -------------------
        [x:Int] |- x :: Int
[T-Lam] ---------------------------    -------------- [T-Num]
        [] |- \x -> x :: Int -> Int    [] |- 2 :: Int
[T-App] -----------------------------------------------
                   [] |- (\x -> x) 2 :: Int
```


<br>

(I) final

    *Answer:* **C**.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


## QUIZ

Which of the following typing relations have a derivation for *some* type `T`?

**(A)** `[]  |-  x + 1  ::  T`

**(B)** `[]  |-  1 2  ::  T`

**(C)** `[]  |-  \x -> x x  ::  T`

**(D)** `[]  |-  (\f y -> f y) (\x -> x + 1)  ::  T`


<br>

(I) final

    *Answer:* **D**.    
    
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

*(A)*

```
     -- NO RULE MATCHES!!!       
        --------------
        [] |- x :: Int   ...
[T-Add]-----------------------
        []  |-  x + 1  ::  T
```

*(B)*

```
      -- NO RULE MATCHES!!!       
       ------------------
       [] |- 1 :: T1 -> T2  ...
[T-App]--------------------------
          []  |-  1 2  ::  T
```

*(C)*

```
          -- CAN'T FIND T1 = (T3 -> T2) = T3
       [x:T1] |- x :: T3 -> T2   [x:T1] |- x :: T3
[T-App]-------------------------------------------
           [x:T1] |- x x :: T2
[T-Lam]-----------------------------
       [] |- \x -> x x  ::  T1 -> T2
```


*(C)*

```
                                       [T-Var]--------  [T-Num]---------
[y:Int,f:Int->Int] |- f y :: Int       [x:Int]|-x::Int  [x:Int]|-1::Int
[T-Lam]------------------------------      ----------------------[T-Add]
[f:Int->Int] |- \y -> f y :: Int->Int      [x:Int] |- x + 1 :: Int
[T-Lam]----------------------------------  ----------------------[T-Lam]
[] |- \f y -> f y :: (Int->Int)->Int->Int  [] |- \x -> x + 1 :: Int->Int
[T-App]-----------------------------------------------------------------
                [] |- (\f y -> f y) (\x -> x + 1)  ::   Int->Int
```



<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Outline

1. Operational Semantics [done]
2. Type System [done]
3. **Type Soundness**


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Well-Typed Programs Always Succeed

We would like to prove the following theorem:

**Theorem** *(Well-Typed Programs Always Succeed):* For any program `e` and type `T`

  - if `[] |- e :: T`, 
  - then there exists a value `v` such that `[] ; e  ==>  v`.

How do we prove theorems about languages?

**By induction.**


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Mathematical induction in PL

### 1. Induction on natural numbers

To prove $\forall n . P(n)$ we need to prove:

  * *Base case:* $P(0)$
  * *Inductive case:* $P(n + 1)$ assuming the *induction hypothesis* (IH): that $P(n)$ holds
  
<br>  
  
Compare with inductive definition for natural numbers:

```haskell
data Nat = Zero     -- base case
         | Succ Nat -- inductive case
```

No reason why this would only work for natural numbers...

In fact we can do induction on *any* inductively defined mathematical object (= any datatype)!

  * lists
  * trees
  * programs!!!
  
<br>
<br>
<br>

### 2. Induction on programs

```haskell
e ::= n 
    | x
    | e1 + e2
    | \x -> e
    | e1 e2
```

To prove $\forall e . P(e)$ we need to prove:

  - *Base case 1:* `P(n)`
  - *Base case 2:* `P(x)`
  - *Inductive case 1:* `P(e1 + e2)` assuming the IH: that `P(e1)` and `P(e2)` hold
  - *Inductive case 2:* `P(\x -> e)` assuming the IH: that `P(e)` holds
  - *Inductive case 3:* `P(e1 e2)` assuming the IH: that `P(e1)` and `P(e2)` hold
  
<br>
<br>
<br>

## Proof: Take 1

**Theorem** For any program `e` and type `T`

  - if `[] |- e :: T`, 
  - then there exists a value `v` such that `[] ; e  ==>  v`.  
  
**Proof:**

*Base case 1* (`n`): By `E-Num` we have `[] ; n ==> n`, hence `v == n`.

...

*Inductive case 3* (`e1 e2`): Assuming that `[] |- e1 e2 :: T`, prove that `[] ; e1 e2  ==>  v`. We need to prove that:

   1. `[] ; e1 ==> <E, x, e>`
   2. `[] ; e2 ==> v2`
   3. `[x:=v2] ; e ==> v`
  
  (2) follows by IH, but 1 and 3 *do not*. We need to generalize the theorem to make the induction go through!
     
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Generalizing the Theorem

Intuitively, we need to change our theorem in three ways:

  1. Generalize to arbitrary `G` and `E`
  2. Prove that the resulting value `v` *has type* `T`
  3. Prove all closures we create *terminate*, when given appropriate arguments
  
<br>
<br>

Let's define what it means for a value to be "well-typed and terminating"!

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Well-Behaved Values

Let's define a new relation: `v :: T` (value `v` is *well-behaved* at type `T`)

  - Intuitive meaning: `v` has type `T` and also terminates on all well-behaved arguments (if it's a closure).
  
```haskell
[V-Num] --------
        n :: Int


               forall v1 :: T1 .  
         (x:=v1,E) ; e ==> v2   v2 :: T2
[V-Clos] -------------------------------
             <E, x, e> :: T1 -> T2
```

<br>
<br>       
  
We extend this relation to environments: `E :: G` (environment `E` is *well-behaved* in context `G`)

  - Intuitive meaning: `G` and `E` have the same variables, and each value in `E` is well-behaved at its `G`-type

```haskell
[E-Nil] --------
        [] :: []
        
           v :: T   E :: G
[E-Bnd] ---------------------
        (x:=v, E) :: (x:T, G)       
```


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Main Lemma

Now we can state our generalized theorem:

**Lemma:** For any program `e`, type `T`, environment `E`, context `G`: 

  (1) If `G |- e :: T`
  (2) and `E :: G`

then there exists a value `v` such that 

  (A) `E ; e  ==>  v`
  (B) and `v :: T`.

  
**Proof:**

*Base case 1* (`n`): 

Because `G |- n :: T`, then `T` is `Int` by `T-Num`.
With `v == n`: (A) `E ; n ==> n` by `E-Num` and (B) `n :: Int` by `V-Num`.

*Base case 2* (`x`): 

Because `G |- x :: T`, we know that `G = (x:T,...)` by `T-Var`.
Hence, from (2) and `E-Bnd` we have `E = (x:=v, ...)` and `v :: T`.
Hence we get: (A) `E ; x ==> v` by `E-Var` and (B) `v :: T`.

*Inductive case 1* (`e1 + e2`): 

Because `G |- e1 + e2 :: T`, then by `T-Add`, `T` is `Int`
and also (3) `G |- e1 :: Int` and (4) `G |- e2 :: Int`.
By IH from (3) we get (5) `E ; e1 ==> v1` and `v1 :: Int`, hence by `V-Num` `v1` is some numeral `n1`.
Similarly from (4) we get (6) `E ; e2 ==> n2`.
With `n = n1 + n2`, we get (A) `E ; (e1 + e2) ==> n` by `E-Add`, and (B) `n :: Int` by `V-Num`.

*Inductive case 2* (`\x -> e`): 

Because `G |- \x -> e :: T`, then by `T-Lam`, `T` is `T1 -> T2`
and also (3) `x:T1, G |- e :: T2`.
Now pick an arbitrary `v1` such that `v1 :: T1`.
Then `x:=v1,E :: x:T1,G` by `E-Bnd` and (2).
Hence using IH on (3) we get (4) `(x:=v1,E) ; e ==> v2` and `v2 :: T2`.
With `v = <E,x,e>` we get (A) `E ; \x -> e  ==>  v` and (B) `v :: T1 -> T2` by `V-Clos` and (4). 

*Inductive case 3* (`e1 e2`): 

Because `G |- e1 e2 :: T`, then by `T-App`
we get (3) `G |- e1 :: T' -> T` and (4) `G |- e2 :: T'`.
By IH from (4) we get (5) `E ; e2 ==> v2` and (6) `v2 :: T'`.
By IH from (3) we get (7) `E ; e1 ==> v1` and (8) `v1 :: T' -> T`, hence by `V-Clos`:
`v1` is a closure `<E',x,e>` and moreover given (6), 
we also have (9) `(x:=v2,E) ; e ==> v` and (10) `v :: T`.
By `E-App` from (7), (5), (9) we have (A) `E ; (e1 e2) ==> v` and (B) follows by (10).

<br>
<br>
<br>

## Now to the Theorem

**Theorem** For any program `e` and type `T`

  - if `[] |- e :: T`, 
  - then there exists a value `v` such that `[] ; e  ==>  v`.  
  
**Proof:**
Because `[] :: []` by `E-Nil`, we can invoke *Lemma* with `G = []`, `E = []` to get `v` such that `[] ; e ==> v`.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

That's all folks
  
