import TestFramework.TestRunner 
import Data.List (foldl')

buyAndSellStock :: [Double] -> Double 
buyAndSellStock xs = snd . foldl' f (head xs, 0) $ xs where 
    f (lmin,r) x = (min lmin x, max (max 0 (x-lmin)) r)

main = goTest 
    buyAndSellStock
    (doubleList . head)
    (doubleData . head . tail)
    cmpDouble 
    "../test_data/buy_and_sell_stock.tsv"