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
    ,   intList 
    ,   doubleList
    ,   listToTuple2
    ) where

import TestFramework.EPIPrelude hiding (takeWhile)
import Data.Attoparsec.Text
import Data.Char 

type Name = Text

data DataType = 
        TupleDT [DataType] Name
    |   IntDT (Maybe Name)
    |   LongDT (Maybe Name)
    |   DoubleDT (Maybe Name)
    |   BoolDT (Maybe Name)
    |   ListDT DataType (Maybe Name)
    |   VoidDT
    deriving (Show)

data Data = 
        TupleD DataType [Data]
    |   IntD DataType Int
    |   LongD DataType Integer
    |   DoubleD DataType Double
    |   BoolD DataType Bool
    |   ListD DataType [Data]
    |   VoidD
    |   Explanation Text

instance Show Data where 
    show (TupleD _ ds)   = show ds 
    show (IntD _ x)      = show x
    show (LongD _ x)     = show x 
    show (DoubleD _ x)   = show x
    show (BoolD _ x)     = show x 
    show (ListD _ x)     = show x
    show VoidD           = "void"
    show (Explanation x) = show x

p_dts :: Parser [DataType]
p_dts = p_dt `sepBy1'` tab

p_dt :: Parser DataType
p_dt = choice [
        p_tuple_dt
    ,   p_int_dt
    ,   p_long_dt
    ,   p_double_dt
    ,   p_bool_dt
    ,   p_list_dt
    ,   p_void_dt
    ]
    <?> "Type"

p_d :: Bool -> Parser Char -> [DataType] -> Parser [Data] 
p_d True  _ [] = pure . Explanation <$> (takeTill isEndOfLine) 
p_d False _ [] = return []
p_d parseExpl sep (dt@(TupleDT dts _):rest) = do
    [x] <- (p_tuple dts) `manyTill` (try sep)
    xs  <- p_d parseExpl sep rest 
    return $ TupleD dt x:xs
p_d parseExpl sep (dt@(IntDT _):rest) = do
    [x] <- case rest of
        -- sep is not found for last element of tuple so not using manyTill
        -- as it consumes until sep succeeds
        [] -> pure <$> p_int dt 
        _  -> p_int dt `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest 
    return $ x:xs
p_d parseExpl sep (dt@(LongDT _):rest) = do 
    [x] <- case rest of
        [] -> pure <$> p_long
        _  -> p_long `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest 
    return $ LongD dt x:xs
p_d parseExpl sep (dt@(DoubleDT _):rest) = do 
    [x] <- case rest of 
        [] -> pure <$> p_double dt
        _  -> p_double dt `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest
    return $ x:xs
p_d parseExpl sep (dt@(BoolDT _):rest) = do 
    [x] <- case rest of 
        [] -> pure <$> p_bool 
        _  -> p_bool `manyTill` (try sep)
    xs  <- spaces *> p_d parseExpl sep rest 
    return $ BoolD dt (readBool . unpack $ x):xs
p_d parseExpl sep (dt@(ListDT ldt _):rest) = do 
    [x] <- p_list dt ldt `manyTill` sep 
    xs  <- p_d parseExpl sep rest 
    return $ x:xs
p_d parseExpl sep (VoidDT:rest) = do 
    xs <- spaces *> p_d parseExpl sep rest 
    return $ VoidD:xs 

spaces :: Parser ()
spaces = takeWhile (==' ') >> return ()

between :: Parser b -> Parser b -> Parser a -> Parser a
between l r m = l *> m <* r 

p_int :: DataType -> Parser Data 
p_int dt = IntD dt <$> signed decimal

p_long :: Parser Integer
p_long = signed decimal

p_double :: DataType -> Parser Data
p_double dt = DoubleD dt <$> double
    
p_bool :: Parser Text 
p_bool = string (pack "true") <|> string (pack "false") <?> "Bool"

p_tuple :: [DataType] -> Parser [Data]
p_tuple dts = between (char '[') (char ']') (p_d False (char ',') dts)

p_list :: DataType -> DataType -> Parser Data
p_list dt ldt@(IntDT _) = ListD dt <$> 
    between (char '[') (char ']') ((spaces *> p_int ldt) `sepBy` (char ','))
p_list dt ldt@(DoubleDT _) = ListD dt <$> 
    between (char '[') (char ']') ((spaces *> p_double ldt) `sepBy` (char ','))

p_single_field_name :: Parser Text
p_single_field_name = (char '[') *> (takeTill (\c -> c=='[' || c==']')) <* (char ']') 

p_tuple_dt :: Parser DataType
p_tuple_dt = TupleDT
    <$> (string (pack "tuple") 
     *> (char '(' *> ((spaces >> p_dt) `sepBy'` (char ',')) <* char ')'))
    <*> between (char '[') (char ']') (takeTill (==']'))

p_int_dt :: Parser DataType
p_int_dt = IntDT <$> 
    (
        string (pack "int") 
    *>  optional p_single_field_name
    )

p_long_dt :: Parser DataType
p_long_dt = LongDT <$>
    (
        string (pack "long")
    *>  optional p_single_field_name
    )

p_double_dt :: Parser DataType
p_double_dt = DoubleDT <$>
    (
        string (pack "float")
    *>  optional p_single_field_name
    )

p_bool_dt :: Parser DataType
p_bool_dt = BoolDT <$>
    (
        string (pack "bool")
    *>  optional p_single_field_name
    )

p_list_dt :: Parser DataType
p_list_dt = ListDT <$> 
    (
        string (pack "array") 
    *>  (char '(' *> p_dt <* char ')') 
    )
    <*> optional p_single_field_name

p_void_dt :: Parser DataType
p_void_dt = string (pack "void") *> return VoidDT

tab :: Parser Char 
tab = char '\t'

p_tsv :: Parser ([DataType],[[Data]])
p_tsv = do 
    dts <- p_dts <* endOfLine
    ds  <- sepBy1' (p_d True tab dts) endOfLine
    return (dts,ds)

readBool :: String -> Bool
readBool "false" = False 
readBool "true"  = True 
readBool x       = read x

testCases :: String -> IO [[Data]]
testCases fileName = do
    contents <- readFile fileName
    case eitherResult (feed (parse p_tsv contents) empty) of 
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

intList :: Data -> [Int]
intList (ListD _ ds) = intData <$> ds

doubleList :: Data -> [Double]
doubleList (ListD _ ds) = doubleData <$> ds

listToTuple2 :: [a] -> (a,a)
listToTuple2 (x:y:_) = (x,y)