import           Debug.Trace
import           TestFramework.TestRunner

sqroot :: Double -> Double
sqroot x | x == 0 = 0
sqroot x | x == 1 = 1
sqroot x | x > 1 = fun 1 x x
sqroot x | x < 1 = fun x 1 x

fun :: Double -> Double -> Double -> Double
fun lo hi x =
  let
    m = (lo + hi) / 2
  in
    if abs (m*m - x) <= 0.0000001
      then m
      else if m*m > x then fun lo m x else fun m hi x

main :: IO ()
main = goTest
  sqroot
  (doubleData . head)
  (doubleData . (!!1))
  cmpDouble
  "../test_data/real_square_root.tsv"
