import           Debug.Trace
import           TestFramework.TestRunner

sqroot :: Double -> Double
sqroot x = x -- TODO

main :: IO ()
main = goTest
  sqroot
  (doubleData . head)
  (doubleData . (!!1))
  cmpDouble
  "../test_data/real_square_root.tsv"
