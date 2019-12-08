---
title: Type Soundness and Termination in One Easy Lemma
date: 2018-05-21
headerImg: books.jpg
---

## Syntax

**Expressions:**

```haskell
e ::= n        -- numeral
    | x        -- variable
    | e1 + e2  -- addition
    | \x -> e  -- abstraction
    | e1 e2    -- application        
```

**Values:**

```haskell
v ::= n         -- numeral
    | <E, x, e> -- closure
```

**Environments:**

```haskell
E ::= []        -- empty
    | x := v, E -- value binding and rest
```

**Types:**

```haskell
T ::= Int       -- integers
    | T1 -> T2  -- function types
```

**Contexts:**

```haskell
G ::= []      -- empty
    | x:T, G  -- type binding and rest
```


## Operational Semantics

We define the *evaluation relation* `E ; e ==> v` as follows: 

```haskell

[E-Num] -------------
        E ; n  ==>  n
         
         
[E-Var] --------------------
        (x:=v,E) ; x  ==>  v


          E ; e1 ==> n1   E ; e2 ==> n2   n == n1 + n2
[E-Add]   --------------------------------------------
                      E ; (e1 + e2) ==> n

          
[E-Lam]   ---------------------------
          E ; (\x -> e) ==> <E, x, e>
       
        E ; e1 ==> <E', x, e>   E ; e2 ==> v2   (x:=v2,E') ; e ==> v
[E-App] ---------------------------------------------------------------
                               E ; (e1 e2) ==> v
```


## Static Semantics

Now we want to define the *typing relation* `G |- e :: T` as follows:

```haskell
        --------------
[T-Num]  G |- n :: Int

        ---------------
[T-Var] x:T, G |- x :: T

         G |- e1 :: Int   G |- e2 :: Int
[T-Add]  -------------------------------
               G |- e1 + e2 :: Int


          x:T1, G |- e :: T2
[T-Lam] ------------------------
        G |- \x -> e :: T1 -> T2
        
        G |- e1 :: T1 -> T2   G |- e2 :: T1
[T-App] -----------------------------------
                 G |- e1 e2 :: T2
```

## Well-Behaved Values

To prove our lemma, we will need two auxiliary relations: 
`v :: T` (value `v` is *well-behaved* at type `T`) 
and `E :: G` (environment `E` is *well-behaved* in context `G`),
defined as follows: 

```haskell
[V-Num] --------
        n :: Int


               forall v1 :: T1 .  
         (x:=v1,E) ; e ==> v2   v2 :: T2
[V-Clos] -------------------------------
             <E, x, e> :: T1 -> T2


[E-Nil] --------
        [] :: []
        
           v :: T   E :: G
[E-Bnd] ---------------------
        (x:=v, E) :: (x:T, G)       
```

Intuitively, a value is well-behaved at `T` if it's well-typed,
and also terminates on all appropriate well-behaved arguments (if it's a closure). 
An environment is well-behaved if all its values are well-behaved. 

## Lemma

Our main lemma says that well-typed programs in  well-behaved environments
always evaluate to well-behaved values.

**Lemma:** For any `e`, `T`, `E`, `G`: 

  (1) `G |- e :: T`
  (2) `E :: G`

then there exists a value `v` such that 

  (A) `E ; e  ==>  v`
  (B) `v :: T`.
  
**Proof:** Is by induction on the derivation of `G |- e :: T`

*Case* `G |- n :: Int`:

By `E-Num` we have `E ; n ==> n` (A) and by `V-Num` we have `n :: Int` (B).

*Case* `G |- x :: T`:

From `T-Var` we know that `G = (x:T,...)`.
Hence, from (2) and `E-Bnd` we have `E = (x:=v, ...)` and `v :: T`.
Hence we get: (A) `E ; x ==> v` by `E-Var` and (B) `v :: T`.

*Case* `G |- e1 + e2 :: Int`: 

By `T-Add`we get (3) `G |- e1 :: Int` and (4) `G |- e2 :: Int`.
By *IH* from (3) we get (5) `E ; e1 ==> v1` and `v1 :: Int`, 
hence by `V-Num`, `v1` is some numeral `n1`.
Similarly from (4) we get (6) `E ; e2 ==> n2`.
With `n = n1 + n2`, we get (A) `E ; (e1 + e2) ==> n` by `E-Add`, and (B) `n ::: Int` by `V-Num`.

*Case* `G |- \x -> e :: T1 -> T2`: 

By `T-Lam`, we get (3) `x:T1, G |- e :: T2`.
Now pick an arbitrary `v1` such that `v1 :: T1`.
Then `x:=v1,E  ::  x:T1,G` by `E-Bnd` and (2).
Hence using *IH* on (3), we get (4) `(x:=v1,E) ; e ==> v2` and `v2 :: T2`.
With `v = <E,x,e>` we get (A) `E ; \x -> e  ==>  v` and (B) `v :: T1 -> T2` by `V-Clos` and (4). 

*Case* `G |- e1 e2 :: T`: 

By `T-App` we get (3) `G |- e1 :: T' -> T` and (4) `G |- e2 :: T'`.
By *IH* from (4) we get (5) `E ; e2 ==> v2` and (6) `v2 :: T'`.
By *IH* from (3) we get (7) `E ; e1 ==> v1` and (8) `v1 :: T' -> T`, hence by `V-Clos`:
`v1` is a closure `<E',x,e>` and moreover given (6), 
we also have (9) `(x:=v2,E) ; e ==> v` and (10) `v :: T`.
By `E-App` from (7), (5), (9) we have (A) `E ; (e1 e2) ==> v` and (B) follows by (10).

*QED*


## Well-Typed Programs Always Succeed

**Theorem** *(Well-Typed Programs Always Succeed):* 
For any program `e` and type `T`, if `[] |- e :: T`, 
then there exists value `v` such that `[] ; e  ==>  v`.
  
**Proof:**
Because `[] :: []` by `E-Nil`, we can invoke **Lemma** with `G = []`, `E = []` to get `v` such that `[] ; e ==> v`.

*QED*

