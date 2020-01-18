import TestFramework.TestRunner 
import Data.List (foldl')

buyAndSellStockTwice :: [Double] -> Double 
buyAndSellStockTwice xs = maximum 
    [
        snd . foldl' f (head xs, 0) . zip (tail bestSndDeals) $ xs -- two trxs
    ,   lx - head xs -- one trx
    ,   0 -- no trxs
    ]
    where 
        lx = last xs
        f (lmin,res) (p2,x) = (min lmin x, max res (p2 + x - lmin))
        bestSndDeals = fst . foldr bsd ([], lx) $ xs 
        bsd x ([],_) = ([0],x)
        bsd x (y:ys,rmax)
            | y >= rmax - x = (y:y:ys, max rmax x)
            | otherwise = (rmax - x : y : ys, max rmax x)

main = goTest 
    buyAndSellStockTwice
    (doubleList . head)
    (doubleData . head . tail)
    cmpDouble 
    "../test_data/buy_and_sell_stock_twice.tsv"