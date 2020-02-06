import TestFramework.TestRunner 
import qualified Data.Map as M
import TestFramework.Randomness
import System.Random
import Data.List (sort,find)
import Data.Maybe (isNothing)

randomPermutation :: RandomGen g => Int -> g -> ([Int],g)
randomPermutation n g = ([0..n-1], g) -- TODO 

randomSamplingWrapper :: RandomGen g => Int -> g -> ([[Int]],g)
randomSamplingWrapper n = collectRandom 10000 (randomPermutation n) 

chk :: Int -> [[Int]] -> Maybe String
chk n ys = either Just (const Nothing) $ do 
    let permIds = fmap (\p -> (p, (perms M.!?) $ p)) ys 
    rightIfNothing 
        (\p -> "Invalid sample " ++ show (fst p)) 
        (find (isNothing . snd) permIds)
    if not (checkUniformRandomness 5 (snd <$> permIds) permsCount)
        then Left "Samples are not uniformly random"
        else Right ()
    where
        xs = [0..n-1] 
        perms = permutationsWithIds (sort xs)
        permsCount = M.size perms

main = do
    g <- getStdGen 
    goTestRandomVoid
        g
        randomSamplingWrapper
        (intData . head)
        chk
        1
        "../test_data/random_permutation.tsv"