{-# LANGUAGE NoImplicitPrelude #-}

module TestFramework.TestRunner 
    (
        goTest
    ,   goTestVoid
    ,   goTestRandomVoid
    ,   uncurry2
    ,   allInRange    
    ,   splitWhen
    ,   cmpDouble
    ,   rightIfNothing
    ,   TestCase
    ,   module TestFramework.TestParser
    ) where 

import TestFramework.EPIPrelude
import System.Random
import TestFramework.TestParser
import System.CPUTime
import Control.Exception (evaluate)
import Debug.Trace

time :: IO a -> IO (a, Int)
time a = do 
    start <- getCPUTime
    v     <- a
    end   <- getCPUTime 
    let diff = (fromIntegral (end - start)) `div` 1000000
    return (v,diff)

type TestCase = [Data]

goTest :: (Show a, Eq b, Show b) =>
        (a -> b)               -- Function to test 
    ->  (TestCase -> a)        -- Test case to function input    
    ->  (TestCase -> b)        -- Test case to function output 
    ->  (b -> b -> Bool)       -- Result Comparator
    ->  String                 -- File name of test data
    ->  IO ()
goTest f fin fout cmp fileName = do 
    ts <- testCases fileName
    runTests [] 1 (length ts) f fin fout cmp ts 

runTests :: (Show a, Show b) =>
        [Int]                    -- Run times of test cases
    ->  Int                      -- Test case number
    ->  Int                      -- Total number of test cases
    ->  (a -> b)                 -- Function to test 
    ->  (TestCase -> a)          -- Test case to function input
    ->  (TestCase -> b)          -- Test case to expected output
    ->  (b -> b -> Bool)         -- Comparator function
    ->  [TestCase]               -- List of test cases
    ->  IO ()                    
runTests rts _ _ _ _ _ _ [] = printCongrats rts
runTests rts i n f fin fout cmp (t:ts) = do
    let input    = fin t 
        expected = fout t
    (res, rt) <- time $ return $ f input 
    if res `cmp` expected 
        then do
            printSuccess i n rt 
            runTests (rt:rts) (i+1) n f fin fout cmp ts
        else do 
            printFailure i n t 
            printFailureInfoAndExpl t expected res

goTestVoid :: (Show a, Eq b, Show b) =>
        (a -> b)                  -- Function to test 
    ->  (TestCase -> a)           -- Test case to function input 
    ->  (a -> b -> (Bool,String)) -- Output checker function with fail info
    ->  String                    -- Test data file name
    ->  IO ()
goTestVoid f fin chk fileName = do 
    ts <- testCases fileName
    runTestsVoid [] 1 (length ts) f fin chk ts 

runTestsVoid :: (Show a, Show b) =>
        [Int]                     -- Run times of test cases
    ->  Int                       -- Test case number
    ->  Int                       -- Total number of test cases
    ->  (a -> b)                  -- Function to test 
    ->  (TestCase -> a)           -- Test case to function input
    ->  (a -> b -> (Bool,String)) -- Output checker function
    ->  [TestCase]                -- List of test cases
    ->  IO ()
runTestsVoid rts _ _ _ _ _ [] = printCongrats rts
runTestsVoid rts i n f fin chk (t:ts) = do 
    let input = fin t 
    (res, rt) <- time $ evaluate $ f input
    case chk input res of 
        (True, _) -> do 
            printSuccess i n rt 
            runTestsVoid (rt:rts) (i+1) n f fin chk ts
        (False, failureInfo) -> do 
            printFailure i n t
            printColored yellow "Failure info"
            printf ":             "
            printf "%s\n" failureInfo

goTestRandomVoid :: (RandomGen g, Show a, Eq b, Show b) =>
        g 
    ->  (a -> g -> (b,g))         -- Function to test 
    ->  (TestCase -> a)           -- Test case to function input 
    ->  (a -> b -> Maybe String)  -- Output checker function returning fail info
    ->  String                    -- Test data file name
    ->  IO ()
goTestRandomVoid g f fin chk fileName = do 
    ts <- testCases fileName
    runTestsRandomVoid g [] 1 (length ts) f fin chk ts 

runTestsRandomVoid :: (Show a, Show b, RandomGen g) =>
        g                         -- RandomGen 
    ->  [Int]                     -- Run times of test cases
    ->  Int                       -- Test case number
    ->  Int                       -- Total number of test cases
    ->  (a -> g -> (b,g))         -- Function to test 
    ->  (TestCase -> a)           -- Test case to function input
    ->  (a -> b -> Maybe String)  -- Output checker function returning fail info
    ->  [TestCase]                -- List of test cases
    ->  IO ()
runTestsRandomVoid _ rts _ _ _ _ _ [] = printCongrats rts
runTestsRandomVoid g rts i n f fin chk (t:ts) = do 
    let input = fin t 
    ((res,g'), rt) <- time $ return $ f input g
    case chk input res of 
        Nothing -> do 
            printSuccess i n rt 
            runTestsRandomVoid g' (rt:rts) (i+1) n f fin chk ts
        Just failureInfo -> do 
            printFailure i n t
            printColored yellow "Failure info"
            printf ":             "
            printf "%s\n" failureInfo

printSuccess :: Int -> Int -> Int -> IO ()
printSuccess i n rt = do 
    printf "\rTest "
    printColored green "PASSED"
    printf " (%5d/%d) [%4d us]" i n rt
    
type Color = String

yellow :: Color 
yellow   = "\x1b[33m"

green :: Color 
green    = "\x1b[32m"

colorEnd :: Color
colorEnd = "\x1b[0m"

printColored :: Color -> String -> IO () 
printColored c x = printf "%s%s%s" c x colorEnd

printCongrats :: [Int] -> IO ()
printCongrats rts = do 
    printf "\nAverage running time: %4d us" (sum rts `div` length rts)
    printf "\nMedian running time:  %4d us\n" (sort rts !! (length rts `div` 2))
    putStrLn . pack $ "*** You've passed ALL tests. Congratulations! ***"
    return ()    

printFailure :: Int -> Int -> TestCase -> IO ()
printFailure i n t = do 
    let ins = dropRight 2 t -- Dropping expected and explanation
    printf "\rTest \x1b[91mFAILED\x1b[0m (%5d/%d)\n" i n
    printColored yellow "Arguments"
    printf "\n"
    forM_ ([(1::Int)..] `zip` ins) $ \(idx, x) -> do
        printf "\t"
        printColored yellow ("Input" ++ show idx)
        printf ":           "
        putStrLn (pack (show x))
    printf "\n"

printFailureInfoAndExpl :: (Show b) => TestCase -> b -> b -> IO () 
printFailureInfoAndExpl t expected result = do
    let Explanation expl = last t
    printColored yellow "Failure info"
    printf "\n\t"
    printColored yellow "explanation"
    putStrLn (pack ":      " `append` expl)
    printf "\t"
    printColored yellow "expected"
    printf ":         "
    printf "%s\n\t" (show expected)
    printColored yellow "result"
    printf ":           "
    printf "%s\n" (show result)

uncurry2 :: (a -> b -> c -> d) -> ((a,b,c) -> d)
uncurry2 f (x,y,z) = f x y z 

allInRange :: (Ord a) => a -> a -> [a] -> Bool 
allInRange lo hi = all (\x -> lo <= x && x <= hi) 

splitWhen :: (a -> Bool) -> [a] -> ([a],[a])
splitWhen p = f [] where
    f ls [] = (reverse ls,[])
    f ls (x:xs) 
        | p x = (reverse ls,x:xs)
        | otherwise = f (x:ls) xs

cmpDouble :: Double -> Double -> Bool 
cmpDouble x y = abs (x - y) < 0.00001

rightIfNothing :: (a -> e) -> Maybe a -> Either e ()
rightIfNothing f Nothing  = Right () 
rightIfNothing f (Just x) = Left $ f x 
