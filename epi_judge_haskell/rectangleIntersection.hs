import TestFramework.TestRunner

data Rectangle = Rectangle {
        _x :: Int
    ,   _y :: Int 
    ,   _width :: Int 
    ,   _height :: Int
    } deriving (Show, Eq)

intersectRectangle :: Rectangle -> Rectangle -> Rectangle
intersectRectangle r1 r2 = r1 -- TODO

toRect :: Data -> Rectangle
toRect t = 
    let (x,y,w,h) = tuple4Data t
    in  Rectangle (intData x) (intData y) (intData w) (intData h)

fin :: TestCase -> (Rectangle, Rectangle)
fin c = let [r1,r2] = toRect <$> take 2 c in (r1,r2)

fout :: TestCase -> Rectangle
fout c = toRect (c !! 2)

main = goTest 
    (uncurry intersectRectangle) 
    fin 
    fout
    (==)
    "../test_data/rectangle_intersection.tsv"