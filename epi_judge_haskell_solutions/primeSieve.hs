import TestFramework.TestRunner 
import qualified Data.Vector.Mutable as MV
import qualified Data.Vector as V
import Control.Monad.ST
import Control.Monad

primes :: Int -> [Int]
primes n = drop 2 . fmap fst . filter (id . snd) . zip [0..] . V.toList $ table
    where
        table = runST $ do
            v <- MV.replicate (n+1) True
            forM_ [2..n] $ \i ->
                forM_ [i*i,i*(i+1)..n] $ \j -> MV.write v j False
            V.freeze v

main = goTest 
    primes 
    (intData . head)
    (intList . head . tail)
    (==)
    "../test_data/prime_sieve.tsv"