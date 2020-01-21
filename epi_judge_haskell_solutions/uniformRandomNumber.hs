import TestFramework.TestRunner 
import TestFramework.Randomness
import System.Random
import Data.List (find)

zeroOneRandom :: RandomGen g => g -> (Int,g) 
zeroOneRandom = randomR (0,1)

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

chk :: (Int,Int) -> [Int] -> Maybe String
chk (lo,hi) res = either Just (const Nothing) $ do
    rightIfNothing
        (\r -> "Generated number " ++ show r ++ " is not in range " ++ show (lo,hi))
        (find (\r -> r<lo || r>hi) res)
    if not (checkUniformRandomness [x-lo | x <- res] (hi-lo+1))
        then Left "Generated numbers are not uniformly random"
        else Right ()

main = do 
    g <- getStdGen
    goTestRandomVoid
        g
        (uncurry uniformRandomWrapper)
        (\(lo:hi:_) -> (intData lo, intData hi))
        chk
        "../test_data/uniform_random_number.tsv"