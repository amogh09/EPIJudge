import TestFramework.TestRunner
import Data.Text (unpack)
import Data.List (sort)

validIps :: String -> [String]
validIps xs = [xs] -- TODO

fout :: TestCase -> [String]
fout t = if r == [""] then [] else r where 
    r = textList . head . tail $ t

main = goTest 
    validIps
    (unpack . textData . head)
    fout
    (\x y -> sort x == sort y)
    "../test_data/valid_ip_addresses.tsv"