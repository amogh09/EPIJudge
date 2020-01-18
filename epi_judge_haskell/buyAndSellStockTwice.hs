import TestFramework.TestRunner 

buyAndSellStockTwice :: [Double] -> Double 
buyAndSellStockTwice xs = 0 -- TODO 

main = goTest 
    buyAndSellStockTwice
    (doubleList . head)
    (doubleData . head . tail)
    cmpDouble 
    "../test_data/buy_and_sell_stock_twice.tsv"