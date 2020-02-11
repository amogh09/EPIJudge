import TestFramework.TestRunner
import Data.Text (unpack)
import Data.List (inits,tails,intercalate,sort,intersperse)
import qualified Data.Vector as V
import Numeric (readDec)

-- [1,2,3,4] -> [([1],[2,3,4]), ([1,2],[3,4]), ([1,2,3],[4])]
splits :: V.Vector a -> [(V.Vector a, V.Vector a)]
splits xs = fmap (flip V.splitAt xs) $ [1..V.length xs - 1]

fastRead :: String -> Int
fastRead s = case readDec s of [(n, "")] -> n

validSegment :: V.Vector Char -> Bool
validSegment xs
    | V.length xs == 1 = True
    | V.length xs > 4 = False
    | V.head xs /= '0' && fastRead (V.toList xs) <= 255 = True
    | otherwise = False

validIps :: String -> [String]
validIps = fmap V.toList . f 4 . V.fromList where 
    f :: Int -> V.Vector Char -> [V.Vector Char]
    f n xs 
        | V.null xs = []
        | n == 1 = if validSegment xs then [xs] else []
        | otherwise = concat . fmap (g n) . filter (validSegment . fst) . splits $ xs
    g n (ls,rs) = ((ls V.++) . V.cons '.') <$> f (n-1) rs

joinVec :: a -> [V.Vector a] -> V.Vector a 
joinVec c = V.concat . intersperse (V.singleton c)

validIps' :: String -> [String]
validIps' xs = do
    i <- filter (\i -> validSegment $ V.slice 0 i vxs) [1..n-3] 
    j <- filter (\j -> validSegment $ V.slice i j vxs) [1..n-i-2]
    k <- filter (\k -> validSegment $ V.slice (i+j) k vxs) [1..n-i-j-1]
    if validSegment . V.drop (i+j+k) $ vxs
        then return $ V.toList $ joinVec '.' [
                    V.slice 0 i vxs
                ,   V.slice i j vxs
                ,   V.slice (i+j) k vxs
                ,   V.drop (i+j+k) vxs
                ]
        else [] 
    where 
        vxs = V.fromList xs
        n = V.length vxs

fout :: TestCase -> [String]
fout t = if r == [""] then [] else r where 
    r = textList . head . tail $ t

main = goTest 
    validIps
    (unpack . textData . head)
    fout
    (\x y -> sort x == sort y)
    "../test_data/valid_ip_addresses.tsv"