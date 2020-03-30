import TestFramework.TestRunner 
import qualified Data.LeftistHeap as H 

onlineMedian :: (Integral a) => [a] -> [Double]
onlineMedian xs = []

main = goTest 
    onlineMedian
    (intList . head)
    (doubleList . head . tail)
    cmpDoubleList
    "../test_data/online_median.tsv"