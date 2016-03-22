{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import Test.WebDriver
import Test.WebDriver.Commands

chromeConfig :: WDConfig
chromeConfig = useBrowser chrome defaultConfig


remoteChromeConfig :: WDConfig
remoteChromeConfig = chromeConfig
  { wdHost = "46.101.180.123"
  , wdPort = 4444
  }

main :: IO ()
main = runSession remoteChromeConfig $ do
  openPage "http://google.com"
  searchInput <- findElem ( ByCSS "input[type='text']" )
  sendKeys "Hello, World!" searchInput
  title <- getTitle
  liftIO $ print title
  submit searchInput
  closeSession
