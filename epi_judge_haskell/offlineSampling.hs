import TestFramework.TestRunner 
import TestFramework.Randomness (getAllCombinations, checkUniformRandomness, collectRandom)
import System.Random
import qualified Data.Vector as V
import qualified Data.Map as M
import Data.List (find, sort)
import Data.Maybe (isNothing)

randomSampling :: (Show a, RandomGen g, Ord a) => Int -> [a] -> g -> ([a],g)
randomSampling k xs g = ([],g) -- TODO

randomSamplingWrapper :: (Show a, RandomGen g, Ord a) => Int -> [a] -> g -> ([[a]],g)
randomSamplingWrapper k xs = collectRandom 10000 (randomSampling k xs) 

chk :: (Show a, Ord a) => (Int, [a]) -> [[a]] -> Maybe String
chk (k,xs) ys = either Just (const Nothing) $ do 
    let combIds = fmap (\smp -> (smp, (combs M.!?) . sort $ smp)) ys 
    rightIfNothing 
        (\smp -> "Invalid sample " ++ show (fst smp)) 
        (find (isNothing . snd) combIds)
    if not (checkUniformRandomness (snd <$> combIds) combsCount)
        then Left "Samples are not uniformly random"
        else Right ()
    where
        combs = getAllCombinations k (sort xs)
        combsCount = M.size combs

main = do 
    g <- getStdGen 
    goTestRandomVoid
        g
        (uncurry randomSamplingWrapper)
        (\(x:y:_) -> (intData x, intList y))
        chk
        "../test_data/offline_sampling.tsv"