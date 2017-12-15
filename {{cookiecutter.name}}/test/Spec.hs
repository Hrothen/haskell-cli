import Test.Tasty
import qualified Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Lib


main :: IO ()
main = defaultMain tests


tests :: TestTree
tests = testGroup "Tests" [properties, unitTests]


properties :: TestTree
properties = testGroup "Properties" [qcTests]

qcTests = testGroup "QuickCheck properties"
  [ QC.testProperty "id a == a" $
      \x -> (x :: Int) == id x
  ]

unitTests :: TestTree
unitTests = testGroup "Unit tests" $
  [ testCase "5 < 10" $
      assertBool "5 < 10" (5 < 10)
  ]
