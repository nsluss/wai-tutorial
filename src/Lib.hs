module Lib ( runMain, pureHandler ) where

import Data.ByteString.Builder (stringUtf8, toLazyByteString)
import Data.ByteString.Lazy (ByteString, pack)
import Data.Text (unpack)
import Network.HTTP.Types.Status (status200, status404)
import Network.Wai (Application, Request(pathInfo, queryString), Response, responseLBS)
import Network.Wai.Handler.Warp (run)

import Types (Handler, asApplication)


runMain :: IO ()
runMain = run 8080 app

app :: Application
app = asApplication pureHandler

pureHandler :: Handler
pureHandler request = undefined

notFound :: Response
notFound = responseLBS status404 [] "not found :("
