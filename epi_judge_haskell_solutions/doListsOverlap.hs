import TestFramework.TestRunner
import Data.List (find,elemIndex,tails)
import qualified Data.Set as S
import Data.Maybe (fromJust)

overlap :: [Int] -> [Int] -> [Int] 
overlap xs ys = case (xsCycle, ysCycle) of 
    ([],[])   -> overlapNoCycle xs ys
    (cxs,[])  -> [] 
    ([],cys)  -> [] 
    (cxs,cys) | disjointCycles cxs cys -> []
    (cxs,cys) -> 
        let dx  = fromJust $ elemIndex (head cxs) xs 
            dy  = fromJust $ elemIndex (head cys) ys 
            xs' = drop (abs $ dx - dy) xs 
            ys' = drop (abs $ dy - dx) ys
        in  f xs' ys'
    where 
        xsCycle = isCyclic xs
        ysCycle = isCyclic ys
        xsCyclic = xsCycle /= [] 
        ysCyclic = ysCycle /= []
        f (x:xs) (y:ys) 
            | x == y = x:xs
            | x == head xsCycle = x:xs
            | y == head ysCycle = y:ys
            | otherwise = f xs ys

overlapNoCycle :: (Eq a) => [a] -> [a] -> [a]
overlapNoCycle xs ys = 
    case find f $ tails (drop k xs) `zip` tails (drop (-k) ys) of
        Nothing -> [] 
        Just (us,_) -> us 
    where 
        m = length xs 
        n = length ys 
        k = m - n
        f ([],_)  = False 
        f (_,[])  = False 
        f (ps,qs) = head ps == head qs

disjointCycles :: (Eq a, Show a) => [a] -> [a] -> Bool 
disjointCycles (x:xs) (y:ys) = 
    case find (\x' -> x'==x || x'==y) xs of 
        Just z | z == y -> False 
        Just z | z == x -> True 

steps :: Int -> [a] -> [[a]]
steps _ [] = []
steps k xs = 
    let xs' = drop k xs 
    in  case xs' of 
            [] -> []
            _  -> xs' : steps k xs'

isCyclic :: [Int] -> [Int]
isCyclic xs = case k of 
    Nothing     -> []
    Just (_,qs) -> fst . fromJust . find f $
        (xs:steps 1 xs) `zip` (qs:steps 1 qs)
    where 
        k = find f $ steps 1 xs `zip` steps 2 xs
        f ((x:_), (y:_)) = x == y

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