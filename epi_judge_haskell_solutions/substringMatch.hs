import TestFramework.TestRunner
import Data.Text (unpack)
import Data.Char (ord)
import qualified Data.Vector as V

hash :: V.Vector Char -> Int 
hash = sum . fmap ord . V.toList

nextHash :: Char -> Int -> Char -> Int 
nextHash x' h x = h - ord x' + ord x

rabinKarp :: V.Vector Char -> V.Vector Char -> Int 
rabinKarp text sub = f 1 (V.head text) (hash . V.take k $ text) (V.tail text) where
    subHash = hash sub 
    k = V.length sub
    f i x' h xs 
        | V.length xs < k = -1
        | otherwise =  
            let h' = nextHash x' h (xs V.! (k-1))
            in  if h' == subHash && V.take k xs == sub
                    then i
                    else f (i+1) (V.head xs) h' (V.tail xs)

search :: String -> String -> Int 
search text sub
    | length text < length sub = -1
    | take (length sub) text == sub = 0 
    | otherwise = rabinKarp (V.fromList text) (V.fromList sub) 
        
main = goTest
    (uncurry search)
    (\(x:y:_) -> (unpack . textData $ x, unpack . textData $ y))
    (intData . (!!2))
    (==)
    "../test_data/substring_match.tsv"
    