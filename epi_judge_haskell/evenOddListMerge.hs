import TestFramework.TestRunner

evenOddMerge :: [a] -> [a]
evenOddMerge xs = xs -- TODO Fill here

main = goTest 
    evenOddMerge
    (intList . head)
    (intList . head . tail)
    (==)
    "../test_data/even_odd_list_merge.tsv"