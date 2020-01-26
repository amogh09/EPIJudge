import TestFramework.TestRunner 
import System.Random 
import TestFramework.Randomness (collectRandom, checkUniformRandomness, getAllCombinations)
import qualified Data.Map.Strict as M
import qualified Data.Vector as V
import Data.List (find,sort)
import Data.Maybe (isNothing)

randomSubset :: RandomGen g => Int -> Int -> g -> ([Int],g)
randomSubset n k g = (fmap (vxs V.!) . fmap (iim M.!) $ [0..k-1], g')
    where 
        vxs = V.fromList [0..n-1]
        (iim,g') = foldl f (M.empty,g) [0..k-1]
        f (agg,g) i = let (c,g') = randomR (i,n-1) g 
                          agg'   = M.insert i (M.findWithDefault c c agg) agg
                      in  (M.insert c (M.findWithDefault i i agg) agg', g')

randomSubsetWrapper :: RandomGen g => Int -> Int -> g -> ([[Int]],g)
randomSubsetWrapper n k = collectRandom 10000 (randomSubset n k)

chk :: (Int,Int) -> [[Int]] -> Maybe String 
chk (n,k) ys = either Just (const Nothing) $ do 
    let sampleIds = fmap (\s -> (s, allSamples M.!? (sort s))) ys
    rightIfNothing 
        (\s -> "Invalid subset " ++ show (fst s))
        (find (isNothing . snd) sampleIds)
    if not (checkUniformRandomness 7 (snd <$> sampleIds) samplesCount)
        then Left "Samples are not uniformly random"
        else Right ()
    where 
        xs = [0..n-1]
        allSamples = getAllCombinations k xs
        samplesCount = M.size allSamples

main = do
    g <- getStdGen 
    goTestRandomVoid
        g 
        (uncurry randomSubsetWrapper)
        (\(x:y:_) -> (intData x, intData y))
        chk 
        "../test_data/random_subset.tsv"