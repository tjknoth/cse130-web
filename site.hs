--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Data.List
import Hakyll
import Text.Pandoc
import Text.Pandoc.Walk (walk)

crunchWithCtx ctx = do
  route   $ setExtension "html"
  compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/page.html"    ctx
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls

crunchWithCtxCustom mode ctx = do
  route   $ setExtension "html"
  compile $ pandocCompilerWithTransform
              defaultHakyllReaderOptions
              defaultHakyllWriterOptions
              (walk (toggleMode mode . haskellizeBlock) . walk haskellizeInline)
            >>= loadAndApplyTemplate "templates/page.html"    ctx
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls

-- | Treat an ordered list with uppercase roman numerals as a map:
--   in each item, the first paragraph is the key, and the second is the value;
--   pick the value with key `mode` and discard all other items
toggleMode :: String -> Block -> Block
toggleMode mode (OrderedList (_, UpperRoman, _) items) = select items
  where
    select ([Para [Str key], payload] : rest) =
      if key == mode then payload else select rest
    select _ = Null
toggleMode _ b = b

-- | Make inline code Haskell by default
haskellizeInline :: Inline -> Inline
haskellizeInline (Code (ident, [], kvs) str) = Code (ident, ["haskell"], kvs) str
haskellizeInline i = i

-- | Make code blocks Haskell by default
haskellizeBlock :: Block -> Block
haskellizeBlock (CodeBlock (ident, [], kvs) str) = CodeBlock (ident, ["haskell"], kvs) str
haskellizeBlock b = b

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
  match "static/*/*"       $ do route idRoute
                                compile copyFileCompiler
  match (fromList tops)    $ crunchWithCtx siteCtx
  match "lectures/00-*"    $ crunchWithCtxCustom "final" postCtx
  match "lectures/01-*"    $ crunchWithCtxCustom "final" postCtx
  match "lectures/02-*"    $ crunchWithCtxCustom "final" postCtx
  match "lectures/03-*"    $ crunchWithCtxCustom "final" postCtx
  match "lectures/04-*"    $ crunchWithCtxCustom "lecture" postCtx
  match "lectures/05-*"    $ crunchWithCtxCustom "lecture" postCtx
  match "lectures/06-*"    $ crunchWithCtxCustom "lecture" postCtx
  match "lectures/07-*"    $ crunchWithCtxCustom "lecture" postCtx
  match "lectures/08-*"    $ crunchWithCtxCustom "lecture" postCtx
  match "assignments/*"    $ crunchWithCtx postCtx
  match "templates/*"      $ compile templateCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField  "date"       "%B %e, %Y"  `mappend`
    -- constField "headerImg"  "Eiffel.jpg" `mappend`
    siteCtx

siteCtx :: Context String
siteCtx =
    constField "baseUrl"            "https://tjknoth.github.io/teaching/cse130fa22"     `mappend`
    -- constField "baseUrl"            "https://nadia-polikarpova.github.io/cse130-web"     `mappend`
    constField "site_name"          "cse130"                    `mappend`
    constField "site_description"   "UCSD CSE 130"              `mappend`
    constField "site_username"      "Tristan Knoth"              `mappend`
    constField "github_username"    "tjknoth"      `mappend`
    constField "piazza_classid"     "ucsd/fall2022/cse130/home" `mappend`
    defaultContext


tops =
  [ "index.md"
  , "grades.md"
  , "lectures.md"
  , "links.md"
  , "assignments.md"
  , "calendar.md"
  ]
