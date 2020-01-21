import TestFramework.TestRunner 
import TestFramework.Randomness (getAllCombinations, checkUniformRandomness, collectRandom)
import System.Random
import qualified Data.Vector as V
import qualified Data.Map as M
import Data.List (find, sort)
import Data.Maybe (isNothing)

randomSampling :: (Show a, RandomGen g, Ord a) => Int -> [a] -> g -> ([a],g)
randomSampling k xs g = (fmap (vxs V.!) . fmap (iim M.!) $ [0..k-1], g')
    where 
        vxs = V.fromList xs
        n = V.length vxs
        (iim,g') = foldl f (M.empty,g) [0..k-1]
        f (agg,g) i = let (c,g') = randomR (i,n-1) g 
                          agg'   = M.insert i (M.findWithDefault c c agg) agg
                      in  (M.insert c (M.findWithDefault i i agg) agg', g')

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