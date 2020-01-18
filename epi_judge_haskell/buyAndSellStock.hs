import TestFramework.TestRunner 
import Data.List (foldl')

buyAndSellStock :: [Double] -> Double 
buyAndSellStock xs = 0 -- TODO

main = goTest 
    buyAndSellStock
    (doubleList . head)
    (doubleData . head . tail)
    cmpDouble 
    "../test_data/buy_and_sell_stock.tsv"