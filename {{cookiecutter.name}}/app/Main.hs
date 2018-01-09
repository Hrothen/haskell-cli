-- |
-- Module      :  Main
-- Copyright   :  {{cookiecutter.author_name}} {{cookiecutter.year}}
-- License     :  {{cookiecutter.license}}
--
-- Maintainer  :  {{cookiecutter.email}}
-- Stability   :  experimental
-- Portability :  unknown
--
-- {{cookiecutter.description}}
--
module Main where

import Data.Semigroup ((<>))
import System.IO (FilePath, IOMode(..), withFile)

import Options.Applicative

import Config(Config(..), readConfigFile, loadOrCreateConfigFile)


data Options = Options
  { stringParam :: String
  , numberParam :: Int
  , configFile  :: Maybe String
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
  <*> optional (strOption
      (  long "config"
      <> short 'c'
      <> metavar "FILENAME"
      <> help "config file"
      ))


main :: IO ()
main = do
  Options s n cfg <- customExecParser (prefs showHelpOnError) opts
  config  <- readConfigFile `mapM` cfg
  config' <- case config of
    Just c  -> return c
    Nothing -> loadOrCreateConfigFile "{{ cookiecutter.name }}"

  work s n config'
  where
    opts = info (options <**> helper)
      (  fullDesc
      <> header "{{cookiecutter.name}}"
      <> progDesc "{{cookiecutter.description}}"
      )


work :: String -> Int -> Config -> IO ()
work _ _ _ = return ()
