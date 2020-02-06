import TestFramework.TestRunner 
import TestFramework.Randomness 
import System.Random
import qualified Data.Map.Strict as M 
import qualified Data.Set as S
import qualified TestFramework.Counter as C
import Data.List (find)

randomNum :: RandomGen g => [a] -> [Double] -> g -> (a,g)
randomNum xs ps g = (head xs,g) -- TODO 

randomNumWrapper :: RandomGen g => [a] -> [Double] -> g -> ([a],g)
randomNumWrapper xs ps = collectRandom 1000000 (randomNum xs ps)  

chkProb :: (Ord a, Show a) => Int ->  C.Counter a -> (a,Double) -> Bool 
chkProb n freqs (x,p) = 
    if mean < 50
        then True -- not enough data
        else abs (fromIntegral (M.findWithDefault 0 x freqs) - mean) <= 7*stdDev 
    where 
        mean = (fromIntegral n) * p 
        stdDev = sqrt $ (fromIntegral n) * p * (1-p)

chk :: (Ord a, Show a) => ([a],[Double]) -> [a] -> Maybe String 
chk (xs,ps) vs = either Just (const Nothing) $ do 
    let freqs = C.fromList vs 
        n = length vs
        xps = xs `zip` ps
        ys = S.fromList xs
    rightIfNothing 
        (\v -> "Generated random value " ++ show v ++ " is invalid")
        (find (not . flip S.member ys) vs)
    rightIfNothing
        (\(x,p) -> 
                "Value " 
            ++  show x 
            ++  " was not generated with an expected probability of " 
            ++  show p)
        (find (not . chkProb n freqs) xps)

main = do 
    g <- getStdGen 
    goTestRandomVoid
        g
        (uncurry randomNumWrapper)
        (\(x:y:_) -> (intList x, doubleList y))
        chk 
        1
        "../test_data/nonuniform_random_number.tsv"