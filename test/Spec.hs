import Test.Hspec (hspec, describe, it, shouldBe, xit)
import Lib (pureHandler)
import Network.HTTP.Types.Status (status200, status404)
import Network.Wai (defaultRequest, responseLBS, responseStatus)
import Network.Wai.Internal (Request(..), Response(..))
import Data.ByteString.Builder (toLazyByteString)
import Data.ByteString.Lazy (ByteString(..))

extractLBSResponse :: Response -> Maybe ByteString
extractLBSResponse (ResponseBuilder _ _ builder) = Just $ toLazyByteString builder
extractLBSResponse _ = Nothing

main :: IO ()
main = hspec $ do
  describe "pureHandler" $ do
    it "should respond to the / route" $ do
      -- g
      let
        request = defaultRequest
      -- w
        actual = pureHandler request
        expectedStatus = status200
        expectedContent = Just "some content"
      -- t
      responseStatus actual `shouldBe` expectedStatus
      extractLBSResponse actual `shouldBe` expectedContent
    xit "should respond to '/hello/foo' with 'hello, foo'" $ do
      let
      -- g
        request = defaultRequest { pathInfo = ["hello", "foo"] }
      -- w
        actual = pureHandler request
        expectedStatus = status200
        expectedContent = Just "hello, foo"
      -- t
      responseStatus actual `shouldBe` expectedStatus
      extractLBSResponse actual `shouldBe` expectedContent
    xit "should respond to an unknown route with a 404 status" $ do
      -- g
      let
        request = defaultRequest { pathInfo = ["unknown", "route"] }
      -- w
        actual = pureHandler request
        expectedStatus = status404
      -- t
      responseStatus actual `shouldBe` expectedStatus
    xit "should respond to '/?numerator=6&denominator=2' with '3'" $ do
      let
      -- g
        request = defaultRequest { 
            queryString = [
                ("numerator", Just "6"),
                ("denominator", Just "2")
              ] 
          }
      -- w
        actual = pureHandler request
        expectedStatus = status200
        expectedContent = Just "3"
      -- t
      responseStatus actual `shouldBe` expectedStatus
      extractLBSResponse actual `shouldBe` expectedContent

      
