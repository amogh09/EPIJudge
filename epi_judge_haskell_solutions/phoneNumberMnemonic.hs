import TestFramework.TestRunner 
import Data.Text (unpack)
import Data.List (sort)

letters :: Char -> String 
letters '0' = "0"
letters '1' = "1"
letters '2' = "ABC"
letters '3' = "DEF"
letters '4' = "GHI"
letters '5' = "JKL"
letters '6' = "MNO"
letters '7' = "PQRS"
letters '8' = "TUV"
letters '9' = "WXYZ"

mnemonics :: String -> [String]
mnemonics []  = [] 
mnemonics [x] = pure <$> letters x 
mnemonics (x:xs) = 
    let ys = mnemonics xs 
    in  do 
        y <- ys 
        z <- letters x 
        [z:y]

main = goTest 
    mnemonics
    (unpack . textData . head)
    (textList . head . tail)
    (\x y -> sort x == sort y)
    "../test_data/phone_number_mnemonic.tsv"