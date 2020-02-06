import TestFramework.TestRunner 
import TestFramework.Randomness
import System.Random
import Data.List (find)

zeroOneRandom :: RandomGen g => g -> (Int,g) 
zeroOneRandom = randomR (0,1)

uniformRandom :: RandomGen g => Int -> Int -> g -> (Int,g) 
uniformRandom lo hi g = (-1,g) -- TODO

uniformRandomWrapper :: RandomGen g => Int -> Int -> g -> ([Int],g)
uniformRandomWrapper lo hi g = collectRandom 10000 (uniformRandom lo hi) g

chk :: (Int,Int) -> [Int] -> Maybe String
chk (lo,hi) res = either Just (const Nothing) $ do
    rightIfNothing
        (\r -> "Generated number " ++ show r ++ " is not in range " ++ show (lo,hi))
        (find (\r -> r<lo || r>hi) res)
    if not (checkUniformRandomness 7 [x-lo | x <- res] (hi-lo+1))
        then Left "Generated numbers are not uniformly random"
        else Right ()

main = do 
    g <- getStdGen
    goTestRandomVoid
        g
        (uncurry uniformRandomWrapper)
        (\(lo:hi:_) -> (intData lo, intData hi))
        chk
        1
        "../test_data/uniform_random_number.tsv"