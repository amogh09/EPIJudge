import TestFramework.TestRunner 

primes :: Int -> [Int]
primes n = []

main = goTest 
    primes 
    (intData . head)
    (intList . head . tail)
    (==)
    "../test_data/prime_sieve.tsv"