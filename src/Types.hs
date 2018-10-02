module Types (Handler, asApplication) where

import Network.Wai (Request, Response, Application)

type Handler = Request -> Response

asApplication :: Handler -> Application
asApplication handler request callback = callback $ handler request 

