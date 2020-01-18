import TestFramework.TestRunner 
import TestFramework.Randomness
import System.Random

uniformRandom :: RandomGen g => Int -> Int -> g -> (Int,g) 
uniformRandom lo hi g = (0,g) -- TODO

uniformRandomWrapper :: RandomGen g => Int -> Int -> g -> ([Int],g)
uniformRandomWrapper lo hi g = collectRandom 10000 (uniformRandom lo hi) g

collectRandom :: RandomGen g => Int -> (g -> (a,g)) -> g -> ([a],g)
collectRandom k f g = foldr fun ([],g) [1..k] where 
    fun _ (xs,g) = let (x,g') = f g in (x:xs,g')

chk :: (Int,Int) -> [Int] -> (Bool, String)
chk (lo,hi) res = 
    if not (allInRange lo hi res)
        then (False, "Not all numbers in range (" ++ show lo ++ "," ++ show hi ++ ")") 
    else if not (checkUniformRandomness [x-lo | x <- res] (hi-lo+1))
        then (False, "Result is not uniformly random")
        else (True, "")

main = do 
    g <- getStdGen
    goTestRandomVoid
        g
        (uncurry uniformRandomWrapper)
        (\(lo:hi:_) -> (intData lo, intData hi))
        chk
        "../test_data/uniform_random_number.tsv"