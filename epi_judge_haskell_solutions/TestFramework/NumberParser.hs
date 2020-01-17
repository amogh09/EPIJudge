module TestFramework.NumberParser where 

import Text.Parsec.Text
import Text.Parsec.Char
import Data.Char (digitToInt)
import Text.Parsec hiding ((<|>), many, optional)
import TestFramework.EPIPrelude

{- | parse an optional 'sign' immediately followed by a 'nat'. Note, that in
Daan Leijen's code the sign was wrapped as lexeme in order to skip comments
and spaces in between. -}
int :: Integral i => Parser i
int = ap sign nat

-- | parse an optional plus or minus sign, returning 'negate' or 'id'
sign :: Num a => Parser (a -> a)
sign = (char '-' >> return negate) <|> return id

-- | parse non-negative hexadecimal, octal or decimal numbers
nat :: Integral i => Parser i
nat = zeroNumber <|> decimal

-- | parse a 'nat' syntactically starting with a zero
zeroNumber :: Integral i => Parser i
zeroNumber =
  char '0' >> (decimal <|> return 0) <?> ""

{- | parse plain non-negative decimal numbers given by a non-empty sequence
of digits -}
decimal :: Integral i => Parser i
decimal = number 10 digit

-- | parse a non-negative number given a base and a parser for the digits
number :: Integral i => Int -> Parser Char -> Parser i
number base baseDigit = do
  n <- liftM (numberValue base) (many1 baseDigit)
  seq n (return n)

-- | compute the value from a string of digits using a base
numberValue :: Integral i => Int -> String -> i
numberValue base =
  foldl' (\ x -> ((fromIntegral base * x) +) . fromIntegral . digitToInt) 0