import Test.Hspec (hspec, describe, it, shouldBe)

main :: IO ()
main = hspec $ do
  describe "Test Suite" $ 
    it "should have assertions" $ True `shouldBe` False
