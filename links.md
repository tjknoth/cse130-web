---
title: Resources
headerImg: sea.jpg
---

## Text

There is **no text** for CSE 130. We will be using the
lecture notes, and other course materials such as articles, 
web sites, tutorials, etc. will be made available on
this site as appropriate.  

Below you can find a list of books and online resources
that explore various class topics in more depth.

## Give me feedback

* [Feedback form](https://forms.gle/oqJgZQi4Z5qPqLzz9)

## Canvas

I will not be using Canvas unless extenuating circumstances force a discussion
section or lecture to occur virtually.
In that case we will upload the materials to
[canvas](https://canvas.ucsd.edu/courses/41638).

## Lambda Calculus

- [Types and Programming Languages](https://books.google.com/books/about/Types_and_Programming_Languages.html?id=ti6zoAC9Ph8C) by Benjamin Pierce

## Haskell

### Installation Guide

**Per OS Instructions**

- Windows: install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install). You will first install the Windows Subsystem for Linux (WSL), with the administrator-level command `wsl --install`. Once you restart, then ensure you are using version 2, with `wsl -l -v`. If you haven't used this before, you are likely already on WSL2. If not, [check this link to see how to upgrade from 1 to 2](https://learn.microsoft.com/en-us/windows/wsl/install).
- MacOS: Ensure you've agreed to the XCode License agreements, to ensure you have `clang` and other build tools available. Simply run `xcode-select --install`
- Linux: You'll need some usual compiler tools, including `clang` and `nasm`. If you're on a Debian-like build, the `build-essential` package should suffice.

**General instructions**

1. Install [GHCup](https://www.haskell.org/ghcup/)
2. In a terminal, run: `ghcup tui`
3. **Install** and **set** these versions of the tools:
	  1. `Stack`: 2.9.1
	  2. `HLS`: 1.8.0.0
	  3. `Cabal`: 3.6.2.0
	  4. `GHC`: 8.10.7

Once you have `GHC`, `Cabal`, and `Stack` installed,
you can edit your homework in your favorite text editor and build it by running `make`.
For best experience, we recommend using VSCode with the `Haskell` extension;
to make the extension work, you first need to install `HLS` via `ghcup` (see above).

### Books

- [Learn You a Haskell](http://learnyouahaskell.com/) by Miran Lipovača
- [Haskell Programming from First Principles](http://haskellbook.com) by Christopher Allen and Julie Moronuki
- [Programming in Haskell](http://www.cs.nott.ac.uk/~gmh/book.html) by Graham Hutton
- [Real World Haskell](http://book.realworldhaskell.org/) by Bryan O' Sullivan, John Goerzen, and Don Stewart
- [The Haskell School of Expression](http://www.cs.yale.edu/homes/hudak/SOE/) by Paul Hudak
- [Haskell Wiki Book](http://en.wikibooks.org/wiki/Haskell)

### Other Resources

- [Monadic IO](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/07/mark.pdf)
- [Haskell-Lang](http://haskell-lang.org)
- [Getting started with Haskell](https://haskell-lang.org/get-started)
- [What I Wish I Knew When Learning Haskell](http://dev.stephendiehl.com/hask/)
- [Haskell Cheat Sheet](http://cheatsheet.codeslower.com/CheatSheet.pdf)
- [Haskell Pitfalls](http://users.jyu.fi/~sapekiis/haskell-pitfalls/)
- A Simple editor-independent [mini-ide](https://github.com/ndmitchell/ghcid#readme)
- API Search Engines:
  [Hoogle](http://haskell.org/hoogle)
  [Hayoo](http://holumbus.fh-wedel.de/hayoo/hayoo.html)
- Haskell modes:
  [Emacs](https://commercialhaskell.github.io/intero/)
  [Atom](https://atom.io/packages/ide-haskell)
  [Vim](http://projects.haskell.org/haskellmode-vim/)


<!--
## Prolog

- [Tutorial 1](/static/raw/prolog_tutorial.pdf)
- [Tutorial 2](http://kti.ms.mff.cuni.cz/~bartak/prolog/learning.html)
-->

## Fun Articles

- [PL Dictionary](http://www.cs.washington.edu/education/courses/cse341/04au/341dict.html) by Dan Grossman
- [The Humble Programmer](http://www.cs.utexas.edu/users/EWD/ewd03xx/EWD340.PDF) by Edsger Dijkstra
- [Can Your Programming Language Do This?](http://www.joelonsoftware.com/items/2006/08/01.html) by Joel Spolsky
- [Closures in C++](http://herbsutter.wordpress.com/2008/03/29/trip-report-februarymarch-2008-iso-c-standards-meeting/)
- [MapReduce](http://en.wikipedia.org/wiki/MapReduce)


