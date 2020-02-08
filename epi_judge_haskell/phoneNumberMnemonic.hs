import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.List (sort)

mnemonics :: String -> [String]
mnemonics xs = [] -- TODO

main = goTest 
    mnemonics
    (unpack . textData . head)
    (textList . head . tail)
    (\x y -> sort x == sort y)
    "../test_data/phone_number_mnemonic.tsv"