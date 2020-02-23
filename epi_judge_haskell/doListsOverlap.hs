import TestFramework.TestRunner
import Data.List (find,elemIndex,tails)
import qualified Data.Set as S
import Data.Maybe (fromJust)

overlap :: [Int] -> [Int] -> [Int] 
overlap xs ys = xs -- TODO Fill here

tieAt :: Int -> [Int] -> [Int]
tieAt x xs = let (ls,rs) = splitAt x xs in ls ++ cycle rs

wrapper :: ([Int],[Int],[Int]) -> (Int,Int) -> [Int]
wrapper (xs,ys,zs) (i,j) = overlap xs' ys' where 
    (xs',ys',_) = makeInput (xs,ys,zs) (i,j)

makeInput :: ([Int],[Int],[Int]) -> (Int,Int) -> ([Int],[Int],[Int])
makeInput (xs,ys,zs) (i,j) = 
    case (i,j,zs) of 
        (-1,-1,_)     -> (xs ++ zs, ys ++ zs, zs)
        (i,-1,[])     -> (tieAt i xs, ys, [])
        (i,-1,(z:zs)) -> let xs' = tieAt i $ xs ++ (z:zs) 
                             zs' = dropWhile (/=z) xs'
                         in  (xs', ys ++ zs', zs')
        (-1,j,[])     -> (xs, tieAt j ys, [])
        (-1,j,(z:zs)) -> let ys' = tieAt j $ ys ++ (z:zs) 
                             zs' = dropWhile (/=z) ys'
                         in  (xs ++ zs', ys', zs')
        (i,j,[])      -> (tieAt i xs, tieAt j ys, [])

commonNodes :: [Int] -> S.Set Int
commonNodes = f S.empty where 
    f agg (x:_) | x `S.member` agg = agg 
    f agg (x:xs) = f (S.insert x agg) xs
    f agg [] = agg

chk :: (([Int],[Int],[Int]),(Int,Int)) -> [Int] -> Maybe String
chk ((_,_,[]),(_,_)) [] = Nothing 
chk ((_,_,_),(_,_))  [] = Just "Common node is expected"
chk ((xs,ys,zs),(i,j)) (z:_) = 
    let (xs',ys',zs') = makeInput (xs,ys,zs) (i,j)
    in  if z `S.member` commonNodes zs' 
            then Nothing 
            else Just $ show z ++ " is not a common node"

fout :: TestCase -> [Int]
fout = intList . (!!2)

main = goTestVoid 
    (uncurry wrapper)
    (\(p:q:r:s:t:_) -> ((intList p, intList q, intList r),(intData s, intData t))) 
    chk 
    "../test_data/do_lists_overlap.tsv"