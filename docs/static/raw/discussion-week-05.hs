
module Main where

data Entry  -- datatype
    = File String Int -- file constructor: name and size
    | Dir String [Entry] -- directory constructor: name and child entries

homedir = Dir "home"
    [ File "todo" 256
    , Dir "HW0" [ File "Makefile" 575 ]
    , Dir "HW1" [ File "Makefile" 845, File "HW1.hs" 3007]
    ]

{-
size (File "todo" 256)
==> 256
size (Dir "haskell-jokes" [])
==> 0
size homedir
==> 4683 -- 256 + 575 + 845 + 3007
-}

size :: Entry -> Int
size (File name bytes) = bytes
size (Dir name []) = 0
size (Dir name (entry:entries)) = size entry + size subentry
    where
        subentry = Dir name entries



{-
find "." homedir "Makefile"
>> ["./HW0/Makefile", "./HW1/Makefile"]
find "." (Dir "home" []) "home"
>> []
find "./home" (File "todo" 256) "todo"
==> ["./home/todo"]

our result
==> [".HW0"]
-}

-- >>> find "." homedir "Makefile"
find :: String -> Entry -> String -> [String]
find path (File name bytes) needle
    | name == needle = [path ++ "/" ++ needle]
    | otherwise = []
find path (Dir name []) needle = []
find path (Dir name (entry:entries)) needle =
        (currEntryFind :: [String]) ++ (restSearch :: [String])
    where
        currEntryFind = find (path ++ "/" ++ name) entry needle
        restSearch = find path (Dir name entries) needle


main = print "hello"