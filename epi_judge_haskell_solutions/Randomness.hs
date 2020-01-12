module Randomness
    (
        checkUniformRandomness
    ) where 

import EPIPrelude
import qualified Data.Vector as V
import qualified Data.Set as S
import qualified Data.Map as M

toCounter :: (Ord a) => [a] -> M.Map a Int 
toCounter = foldl' (\agg x -> M.insertWith (+) x 1 agg) M.empty 

-- |Checks if distribution of randomly generated values fits a 
--  binomial distribution
checkBinomialDistFit :: (Ord a) => 
        [a]    -- List of values in range [0..n-1]
    ->  Int    -- Upper bound n on values above 
    ->  Bool   -- True if the distribution of values fits binomial distribution
checkBinomialDistFit xs n
    -- At least a binomial mean frequency of 50 for each value
    -- and mean should be at least 50 smaller than number of trials
    -- to make the test meaningful
    | lxs * p < 50 || lxs * (1-p) < 50 = True -- Not enough data 
    | otherwise =  all id $
        [
            abs (fromIntegral freq - mean) <= allowedDev 
        |   (_,freq) <- M.toList freqs
        ]
    where 
        -- 7 std deviations cover 99.9999999997440% 
        -- data points in a binomial distribution
        allowedDev = 7 * stdDev 
        lxs = (fromIntegral $ length xs) :: Double 
        -- p is the proability of random event 
        p = 1.0 / (fromIntegral n)
        -- standard deviation in a binomial dist
        stdDev = sqrt $ lxs * p * (1 - p)
        -- Mean of binomial distribution
        mean = lxs * p 
        freqs = toCounter xs

checkBinomialDistFitPairs :: (Ord a) =>
        [a] 
    ->  Int 
    ->  Bool 
checkBinomialDistFitPairs xs n = checkBinomialDistFit 
    (xs `zip` tail xs)
    (n*n)

checkBinomialDistFitTriples :: (Ord a) => 
        [a]
    ->  Int 
    -> Bool 
checkBinomialDistFitTriples xs n = checkBinomialDistFit
    (zip3 xs (tail xs) (drop 2 xs))
    (n*n*n)

checkBirthdaySpacings :: (Ord a) => 
        [a]    
    ->  Int    
    ->  Bool   
checkBirthdaySpacings xs n
    | numOfSubArrays < minNumberOfSubarrays = True -- not enough data 
    | otherwise = 
        countTolerance * (fromIntegral numOfSubArrays) 
        <= (fromIntegral numOfSubarraysWithReps) 
    where 
        vxs = V.fromList xs
        countTolerance = 0.4
        numOfSubArrays = length vxs - expAvgRepsLen + 1 
        expAvgRepsLen = fromIntegral $ 
            ceiling . sqrt $ log 2 * 2 * (fromIntegral n)
        minNumberOfSubarrays = 1000 
        numOfSubarraysWithReps = length . filter id $ 
            [ 
                (length . S.fromList . V.toList $ V.slice i expAvgRepsLen vxs) 
            <   expAvgRepsLen
            |   i <- [0..length vxs - expAvgRepsLen] 
            ]

checkUniformRandomness :: (Ord a) => 
        [a]    -- List of randomly generated values in range [0..n-1]
    ->  Int    -- Value n such that n << len([a])
    ->  Bool   -- True if list contains uniformly random values
checkUniformRandomness xs n = 
        checkBinomialDistFit xs n 
    &&  checkBinomialDistFitPairs xs n 
    && checkBinomialDistFitTriples xs n 
    && checkBirthdaySpacings xs n