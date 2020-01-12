{-# LANGUAGE NoImplicitPrelude #-}

module TestFramework.TestParser 
    (
        p_tsv
    ,   Data (..) 
    ,   testCases
    ,   intData
    ,   longData
    ,   doubleData
    ,   boolData
    ,   tuple3Data
    ,   tuple4Data
    ) where

import TestFramework.EPIPrelude
import Text.Parsec.Text
import Text.Parsec.Char
import Text.Parsec hiding ((<|>), many, optional)

type Name = String

data DataType = 
        TupleDT [DataType] Name
    |   IntDT (Maybe Name)
    |   LongDT (Maybe Name)
    |   DoubleDT (Maybe Name)
    |   BoolDT (Maybe Name)
    |   VoidDT
    deriving (Show)

data Data = 
        TupleD DataType [Data]
    |   IntD DataType Int
    |   LongD DataType Integer
    |   DoubleD DataType Double
    |   BoolD DataType Bool
    |   VoidD
    |   Explanation Text

instance Show Data where 
    show (TupleD _ ds)   = show ds 
    show (IntD _ x)      = show x
    show (LongD _ x)     = show x 
    show (DoubleD _ x)   = show x
    show (BoolD _ x)     = show x 
    show VoidD           = "void"
    show (Explanation x) = show x

p_dts :: Parser [DataType]
p_dts = p_dt `sepBy` tab

p_dt :: Parser DataType
p_dt = choice [
        p_tuple_dt
    ,   p_int_dt
    ,   p_long_dt
    ,   p_double_dt
    ,   p_bool_dt
    ,   p_void_dt
    ]
    <?> "Type"

p_d :: Bool -> Parser Char -> [DataType] -> Parser [Data] 
p_d True  _ [] = pure . Explanation . pack <$> (many . noneOf $ "\n\r") 
p_d False _ [] = return []
p_d parseExpl sep (dt@(TupleDT dts _):rest) = do
    [x] <- (p_tuple_d dt dts) `manyTill` (try sep)
    xs  <- p_d parseExpl sep rest 
    return $ x:xs
p_d parseExpl sep (dt@(IntDT _):rest) = do
    [x] <- case rest of
        -- sep is not found for last element of tuple so not using manyTill
        -- as it consumes until sep succeeds
        [] -> pure <$> p_int 
        _  -> p_int `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest 
    return $ IntD dt (read x):xs
p_d parseExpl sep (dt@(LongDT _):rest) = do 
    [x] <- case rest of
        [] -> pure <$> p_long
        _  -> p_double `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest 
    return $ LongD dt (read x):xs
p_d parseExpl sep (dt@(DoubleDT _):rest) = do 
    [x] <- case rest of 
        [] -> pure <$> p_double
        _  -> p_double `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest
    return $ DoubleD dt (read x):xs
p_d parseExpl sep (dt@(BoolDT _):rest) = do 
    [x] <- case rest of 
        [] -> pure <$> p_bool 
        _  -> p_bool `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest 
    return $ BoolD dt (readBool x):xs
p_d parseExpl sep (VoidDT:rest) = do 
    xs <- spaces *> p_d parseExpl sep rest 
    return $ VoidD:xs 

p_int = (++) <$> option "" (string "-") <*> many1 digit
p_long = (++) <$> option "" (string "-") <*> many1 digit
p_double = (++) <$> option "" (string "-") <*> (many1 (digit <|> oneOf ".-+e"))
p_bool = string "true" <|> string "false" <?> "Bool"
p_tuple_dt = TupleDT
    <$> (string "tuple" 
     *> between (char '(') (char ')') ((spaces *> p_dt) `sepBy` (char ',')))
    <*> between (char '[') (char ']') (many . noneOf $ "[]")

p_single_field_name = between (char '[') (char ']') (many . noneOf $ "[]") 

p_tuple_d dt dts = TupleD dt 
    <$> between (char '[') (char ']') (p_d False (char ',') dts)
p_int_dt = IntDT <$> 
    (
        string "int" 
    *>  optional p_single_field_name
    )
p_long_dt = LongDT <$>
    (
        string "long"
    *>  optional p_single_field_name
    )
p_double_dt = DoubleDT <$>
    (
        string "float"
    *>  optional p_single_field_name
    )
p_bool_dt = BoolDT <$>
    (
        string "bool"
    *>  optional p_single_field_name
    )
p_void_dt = string "void" *> return VoidDT

p_tsv = do 
    dts <- p_dts <* eol
    ds  <- p_d True tab dts `endBy` eol
    return (dts,ds)
eol   = try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"
    <?> "End of line"

readBool :: String -> Bool
readBool "false" = False 
readBool "true"  = True 
readBool x       = read x

testCases :: String -> IO [[Data]]
testCases fileName = do
    contents <- readFile fileName
    case parse p_tsv "" contents of 
        Left err     -> print err >> return [] 
        Right (_,cs) -> return cs

intData :: Data -> Int 
intData (IntD _ x) = x 

longData :: Data -> Integer
longData (LongD _ x) = x

doubleData :: Data -> Double 
doubleData (DoubleD _ x) = x 

boolData :: Data -> Bool 
boolData (BoolD _ x) = x

tuple3Data :: Data -> (Data, Data, Data)
tuple3Data (TupleD _ [p,q,r]) = (p,q,r)

tuple4Data :: Data -> (Data, Data, Data, Data)
tuple4Data (TupleD _ [p,q,r,s]) = (p,q,r,s)
