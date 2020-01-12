import TestRunner 
import System.Random
import Randomness

zeroOneRandom :: RandomGen g => g -> (Int,g) 
zeroOneRandom = randomR (0,1)

collectRandom :: RandomGen g => Int -> (g -> (a,g)) -> g -> ([a],g)
collectRandom k f g = foldr fun ([],g) [1..k] where 
    fun _ (xs,g) = let (x,g') = f g in (x:xs,g')

binaryToInt :: [Int] -> Int 
binaryToInt xs = f 0 xs where 
    f r [] = r 
    f r (0:xs) = f (r*2) xs 
    f r (1:xs) = f (r*2+1) xs

uniformRandom :: RandomGen g => Int -> Int -> g -> (Int,g) 
uniformRandom lo hi g  
    | lo + r <= hi = (lo+r,g') 
    | otherwise    = uniformRandom lo hi g'
    where 
        digitsCount = (+1) . fromIntegral . ceiling $ 
            logBase 2 . fromIntegral $ (hi - lo)
        (zos,g') = collectRandom digitsCount zeroOneRandom g 
        r = binaryToInt zos

uniformRandomWrapper :: RandomGen g => Int -> Int -> g -> ([Int],g)
uniformRandomWrapper lo hi g = collectRandom 10000 (uniformRandom lo hi) g

main = do 
    g <- getStdGen
    goTestRandomVoid
        g
        (uncurry uniformRandomWrapper)
        (\(lo:hi:_) -> (intData lo, intData hi))
        (
            \(lo,hi) res ->
                if not (allInRange lo hi res)
                    then (False, "Not all numbers in range (" ++ show lo ++ "," ++ show hi ++ ")") 
                else if not (checkUniformRandomness [x-lo | x <- res] (hi-lo+1))
                    then (False, "Result is not uniformly random")
                    else (True, "")
        )
        "../test_data/uniform_random_number.tsv"