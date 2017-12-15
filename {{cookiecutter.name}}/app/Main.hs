-- |
-- Module      :  Main
-- Copyright   :  {{cookiecutter.author_name}} {{cookiecutter.year}}
-- License     :  BSD3
--
-- Maintainer  :  {{cookiecutter.email}}
-- Stability   :  experimental
-- Portability :  unknown
--
-- {{cookiecutter.description}}
--
module Main where

import Data.Semigroup ((<>))

import Options.Applicative


data Options = Options
  { stringParam :: String
  , numberParam :: Int
  } deriving (Show, Read, Eq)


options :: Parser Options
options = Options
  <$> strOption
      (  long "string_param"
      <> short 's'
      <> metavar "STRING"
      <> help "string parameter"
      )
  <*> option auto
      (  long "number_param"
      <> short 'n'
      <> metavar "NUMBER"
      <> help "number parameter"
      <> value 1
      <> showDefault
      )


main :: IO ()
main = work =<< customExecParser (prefs showHelpOnError) opts
  where
    opts = info (options <**> helper)
      (  fullDesc
      <> header "{{cookiecutter.name}}"
      <> progDesc "{{cookiecutter.description}}"
      )


work :: Options -> IO ()
work _ = return ()
