{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module TestFramework.TestParser 
    (
        p_tsv
    ,   Data (..)
    ,   Tree (..)
    ,   testCases
    ,   intData
    ,   longData
    ,   doubleData
    ,   boolData
    ,   textData
    ,   tuple3Data
    ,   tuple4Data
    ,   intList 
    ,   doubleList
    ,   textList
    ,   listToTuple2
    ,   listOfIntList
    ,   tuple2Data
    ,   stringData
    ,   split
    ,   binaryTree
    ,   listData
    ,   module TestFramework.BinaryTreeParser
    ) where

import TestFramework.EPIPrelude hiding (takeWhile)
import TestFramework.BinaryTreeParser
import TestFramework.BinaryTree (Tree(..))
import Data.Attoparsec.Text
import Data.Char 

type Name = Text

data DataType = 
        TupleDT [DataType] (Maybe Name)
    |   IntDT (Maybe Name)
    |   LongDT (Maybe Name)
    |   DoubleDT (Maybe Name)
    |   BoolDT (Maybe Name)
    |   TextDT (Maybe Name)
    |   ListDT DataType (Maybe Name)
    |   BinaryTreeDT DataType (Maybe Name)
    |   VoidDT
    deriving (Show)

data Data = 
        TupleD DataType [Data]
    |   IntD DataType Int
    |   LongD DataType Integer
    |   DoubleD DataType Double
    |   TextD DataType Text
    |   BoolD DataType Bool
    |   ListD DataType [Data]
    |   BinaryTreeD DataType [Maybe Data]
    |   VoidD
    |   Explanation Text

instance Show Data where 
    show (TupleD _ ds)   = show ds 
    show (IntD _ x)      = show x
    show (LongD _ x)     = show x 
    show (DoubleD _ x)   = show x
    show (TextD _ x)     = show x
    show (BoolD _ x)     = show x 
    show (ListD _ x)     = show x
    show (BinaryTreeD _ x)   = show x
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
    ,   p_text_dt
    ,   p_bool_dt
    ,   p_list_dt
    ,   p_binaryTree_dt
    ,   p_void_dt
    ]
    <?> "Type"

parseSingleData :: Bool -> Parser Char -> [DataType] -> Parser Data -> Parser [Data]
parseSingleData isTsv sep rest p = do 
    x  <- p 
    if isTsv || not (null rest) then sep >> return () else return () 
    xs <- spaces *> p_d isTsv sep rest 
    return $ x:xs    

parseMultiData :: Bool -> Parser Char -> [DataType] -> Parser Data -> Parser [Data]
parseMultiData isTsv sep rest p = do 
    x  <- p <* sep 
    xs <- p_d isTsv sep rest 
    return $ x:xs

p_d :: Bool -> Parser Char -> [DataType] -> Parser [Data] 
p_d True  _ [] = pure . Explanation <$> takeTill isEndOfLine 
p_d False _ [] = return []
p_d isTsv sep (dt@(TupleDT dts _):rest) = parseMultiData isTsv sep rest (p_tuple dt dts)
p_d isTsv sep (dt@(ListDT ldt _):rest)  = parseMultiData isTsv sep rest (p_list dt ldt) 
p_d isTsv sep (dt@(BinaryTreeDT bdt _):rest) = parseMultiData isTsv sep rest (p_binaryTree dt bdt)
p_d isTsv sep (dt@(IntDT _):dts)    = parseSingleData isTsv sep dts (p_int dt)
p_d isTsv sep (dt@(LongDT _):dts)   = parseSingleData isTsv sep dts (p_long dt)
p_d isTsv sep (dt@(DoubleDT _):dts) = parseSingleData isTsv sep dts (p_double dt)
p_d isTsv sep (dt@(TextDT _):dts)   = parseSingleData isTsv sep dts (p_text isTsv dt)
p_d isTsv sep (dt@(BoolDT _):dts)   = parseSingleData isTsv sep dts (p_bool dt)
p_d isTsv sep (VoidDT:rest) = do 
    xs <- spaces *> p_d isTsv sep rest 
    return $ VoidD:xs 

spaces :: Parser ()
spaces = takeWhile (==' ') >> return ()

between :: Parser b -> Parser b -> Parser a -> Parser a
between l r m = l *> m <* r 

optionalBetween :: b -> Parser b -> Parser b -> Parser a -> Parser a 
optionalBetween d l r m = option d l *> m <* option d r

p_int :: DataType -> Parser Data 
p_int dt = IntD dt <$> signed decimal

p_long :: DataType -> Parser Data
p_long dt = LongD dt <$> signed decimal

p_double :: DataType -> Parser Data
p_double dt = DoubleD dt <$> double

p_text :: Bool -> DataType -> Parser Data 
p_text isTsv dt = TextD dt <$> optionalBetween '_' 
    (char '"') 
    (char '"')
    (takeTill (flip elem (end :: String))) 
    where end = if isTsv then "\t" else ",]\""
    
p_bool :: DataType -> Parser Data 
p_bool dt = BoolD dt <$> readBool <$> 
    (string "true" <|> string "false" <?> "Bool")

p_tuple :: DataType -> [DataType] -> Parser Data
p_tuple dt dts = TupleD dt <$> 
    between (char '[') (char ']') (p_d False (char ',') dts)

p_list :: DataType -> DataType -> Parser Data
p_list dt ldt@(IntDT _) = ListD dt <$> 
    between (char '[') (char ']') ((spaces *> p_int ldt) `sepBy` (char ','))
p_list dt ldt@(DoubleDT _) = ListD dt <$> 
    between (char '[') (char ']') ((spaces *> p_double ldt) `sepBy` (char ','))
p_list dt ldt@(TextDT _) = ListD dt <$>
    between (char '[') (char ']') ((spaces *> p_text False ldt) `sepBy` (char ','))
p_list dt ldt@(ListDT ldt' _) = ListD dt <$> 
    between (char '[') (char ']') ((spaces *> p_list ldt ldt') `sepBy` (char ','))
p_list dt ldt@(TupleDT tdt' _) = ListD dt <$>
    between (char '[') (char ']') ((spaces *> p_tuple ldt tdt') `sepBy` (char ','))

p_binaryTree :: DataType -> DataType -> Parser Data
p_binaryTree dt bdt@(IntDT _) = BinaryTreeD dt <$> 
    between (char '[') (char ']') 
        ((spaces *> p_binaryTreeKey (between (char '"') (char '"') (p_int bdt))) `sepBy` (char ','))

p_binaryTreeKey :: Parser Data -> Parser (Maybe Data) 
p_binaryTreeKey p = fmap (const Nothing) (string "\"null\"") <|> fmap Just p

p_single_field_name :: Parser Text
p_single_field_name = (char '[') *> (takeTill (\c -> c=='[' || c==']')) <* (char ']') 

p_tuple_dt :: Parser DataType
p_tuple_dt = TupleDT <$> 
    (
        string "tuple" 
    *>  between (char '(') (char ')') ((spaces >> p_dt) `sepBy'` (char ','))
    )
    <*> optional p_single_field_name

p_list_dt :: Parser DataType
p_list_dt = ListDT <$> 
    (
        (string "array" <|> string "linked_list") 
    *>  (char '(' *> p_dt <* char ')') 
    )
    <*> optional p_single_field_name

p_binaryTree_dt :: Parser DataType
p_binaryTree_dt = BinaryTreeDT <$> 
    (
        (string "binary_tree") 
    *>  (char '(' *> p_dt <* char ')') 
    )
    <*> optional p_single_field_name

p_int_dt :: Parser DataType
p_int_dt = IntDT <$> 
    (
        string "int" 
    *>  optional p_single_field_name
    )

p_long_dt :: Parser DataType
p_long_dt = LongDT <$>
    (
        string "long"
    *>  optional p_single_field_name
    )

p_double_dt :: Parser DataType
p_double_dt = DoubleDT <$>
    (
        string "float"
    *>  optional p_single_field_name
    )

p_bool_dt :: Parser DataType
p_bool_dt = BoolDT <$>
    (
        string "bool"
    *>  optional p_single_field_name
    )

p_text_dt :: Parser DataType 
p_text_dt = TextDT <$>
    (
        string "string"
    *>  optional p_single_field_name
    )

p_void_dt :: Parser DataType
p_void_dt = string "void" *> return VoidDT

tab :: Parser Char 
tab = char '\t'

p_tsv :: Parser ([DataType],[[Data]])
p_tsv = do 
    dts <- p_dts <* endOfLine
    ds  <- sepBy1' (p_d True tab dts) endOfLine
    return (dts,ds)

readBool :: Text -> Bool
readBool "false" = False 
readBool "true"  = True 
readBool x       = read . unpack $ x

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

textData :: Data -> Text 
textData (TextD _ x) = x

stringData :: Data -> String 
stringData (TextD _ x) = unpack x

tuple2Data :: Data -> (Data, Data)
tuple2Data (TupleD _ [x,y]) = (x,y)

tuple3Data :: Data -> (Data, Data, Data)
tuple3Data (TupleD _ [p,q,r]) = (p,q,r)

tuple4Data :: Data -> (Data, Data, Data, Data)
tuple4Data (TupleD _ [p,q,r,s]) = (p,q,r,s)

intList :: Data -> [Int]
intList (ListD _ ds) = intData <$> ds

listData :: (Data -> a) -> Data -> [a]
listData f (ListD _ ds) = f <$> ds

doubleList :: Data -> [Double]
doubleList (ListD _ ds) = doubleData <$> ds

textList :: Data -> [String]
textList (ListD _ ds) = unpack <$> textData <$> ds

listOfIntList :: Data -> [[Int]]
listOfIntList (ListD _ ds) = intList <$> ds

listToTuple2 :: [a] -> (a,a)
listToTuple2 (x:y:_) = (x,y)

binaryTree :: (Data -> a) -> Data -> Tree a
binaryTree f (BinaryTreeD _ xs) = makeTree . fmap (fmap f) $ xs

split :: (Eq a) => a -> [a] -> [[a]]
split _ [] = [] 
split x' xs = f $ xs where 
    f (x:xs) | x == x' = [] : f xs 
    f (x:xs) = let (g:gs) = f xs in (x:g) : gs
    f [] = [[]]
