import TestFramework.TestRunner 
import qualified Data.Map as M
import qualified Data.Vector as V
import TestFramework.Randomness
import System.Random
import Data.List (sort,find)
import Data.Maybe (isNothing)

randomPermutation :: (Show a, RandomGen g) => [a] -> g -> ([a],g)
randomPermutation xs g = ((vxs V.!) <$> snd <$> M.toList idxToVals, g') where 
    vxs = V.fromList xs 
    n = V.length vxs
    (idxToVals,g') = foldl f (M.empty,g) [0..n-1] 
    f (agg,g) i = let (j,g') = randomR (i,n-1) g 
                      agg' = M.insert i (M.findWithDefault j j agg) agg
                  in  (M.insert j (M.findWithDefault i i agg) agg', g')

randomSamplingWrapper :: (Show a, RandomGen g, Ord a) => Int -> [a] -> g -> ([[a]],g)
randomSamplingWrapper k xs = collectRandom 10000 (randomPermutation xs) 

chk :: (Show a, Ord a) => (Int, [a]) -> [[a]] -> Maybe String
chk (k,xs) ys = either Just (const Nothing) $ do 
    let permIds = fmap (\p -> (p, (perms M.!?) $ p)) ys 
    rightIfNothing 
        (\p -> "Invalid sample " ++ show (fst p)) 
        (find (isNothing . snd) permIds)
    if not (checkUniformRandomness (snd <$> permIds) permsCount)
        then Left "Samples are not uniformly random"
        else Right ()
    where
        perms = permutationsWithIds (sort xs)
        permsCount = M.size perms

main = do
    g <- getStdGen 
    goTestRandomVoid
        g
        (uncurry randomSamplingWrapper)
        (\(x:y:_) -> (intData y, intList x))
        chk
        "../test_data/online_sampling.tsv"