import TestFramework.TestRunner 
import qualified Data.Map as M
import TestFramework.Randomness
import System.Random
import Data.List (sort,find)
import Data.Maybe (isNothing)

randomSampling :: (Show a, RandomGen g) => Int -> [a] -> g -> ([a],g)
randomSampling k xs g = (snd <$> M.toList smp, g') where 
    (smp,g') = foldl f (M.fromList . zip [0..k-1] $ xs,g) . drop k . zip [0..] $ xs 
    f (smp,g) (i,x) = let (j,g') = randomR (0,i) g
                      in  if j < k then (M.insert j x smp, g') else (smp,g')

randomSamplingWrapper :: (Show a, RandomGen g, Ord a) => Int -> [a] -> g -> ([[a]],g)
randomSamplingWrapper k xs = collectRandom 10000 (randomSampling k xs) 

chk :: (Show a, Ord a) => (Int, [a]) -> [[a]] -> Maybe String
chk (k,xs) ys = either Just (const Nothing) $ do 
    let combIds = fmap (\smp -> (smp, (combs M.!?) . sort $ smp)) ys 
    rightIfNothing 
        (\smp -> "Invalid sample " ++ show (fst smp)) 
        (find (isNothing . snd) combIds)
    if not (checkUniformRandomness 7 (snd <$> combIds) combsCount)
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
        (\(x:y:_) -> (intData y, intList x))
        chk
        1
        "../test_data/online_sampling.tsv"