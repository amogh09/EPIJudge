import TestFramework.TestRunner 
import qualified Data.Vector as V
import Data.List (find)

search :: V.Vector Int -> Maybe Int 
search xs = Just 0 -- TODO 

chk :: V.Vector Int -> Maybe Int -> Maybe String
chk xs (Just i) 
    | i < 0 = Just $ show i ++ " is less than 0"
    | i > V.length xs = Just $ show i ++ " is greater than the length of the vector"
    | otherwise = 
        if xs V.! i == i 
            then Nothing 
            else Just $ "Element " ++ show (xs V.! i) ++ " at index " ++ show i ++ " is not equal to " ++ show i
chk xs Nothing =
    case fmap snd . find (uncurry (==)) . zip [0..] . V.toList $ xs of 
        Nothing -> Nothing 
        Just i  -> Just $ show i ++ " expected but found Nothing"

main = goTestVoid 
    search 
    (V.fromList . intList . head)
    chk
    "../test_data/search_entry_equal_to_index.tsv"