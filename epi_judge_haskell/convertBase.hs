import TestFramework.TestRunner 
import Data.Text (unpack)
import qualified Data.Map as M
import Data.Char (digitToInt, intToDigit, toUpper)

convertBase :: Int -> Int -> String -> String 
convertBase b b' xs = xs -- TODO

fin :: TestCase -> (Int, Int, String)
fin (x:y:z:_) = (   
        fromIntegral . intData $ y
    ,   fromIntegral . intData $ z
    ,   unpack . textData $ x
    )

main = goTest 
    (uncurry2 convertBase)
    fin 
    (unpack . textData . (!!3))
    (==)
    "../test_data/convert_base.tsv"