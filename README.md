# EPI Judge Haskell

This repository provides [EPIJudge](https://github.com/adnanaziz/EPIJudge) problems in Haskell. 

## Project status
The project is under active development and I am working on translating the problems to Haskell along with their solutions. Please see the table at the bottom of this page to get the current status of problems. 

## Test Framework
The project comes with a Haskell Test Framework (see `epi_judge_haskell_solutions/TestFramework`) just like we have one for Python, Java, and C++. It uses the test data provided in EPIJudge without any modifications. The framework works for the problems that have already been translated to Haskell but might not work for pending ones. It will be updated as per requirements of the pending problems when they are translated. I am using [attoparsec](https://hackage.haskell.org/package/attoparsec) to parse test data. As of writing it is generally faster (without any effor at optimizing) than the ones in other languages. 

## Haskell dependencies
The project uses the following Haskell dependencies. All of them can be downloaded using cabal. 

1. attoparsec
1. vector
1. random

## Running the judge from the command line

### Haskell
Compile and run a specific program:

    $ make <program_name> 
Example:

    $ make parity

## FAQ

- How can I contact the authors? 

Please feel free to send me questions and feedback -  `amoghdroid09@gmail.com`

- What Haskell compiler is supported?
  - Any recent GHC version should work. I have developed the project using GHC 8.8.1.
   
## Problem to Program Mapping

(You may have to scroll to the right to view the Python column.)

| Problem | Haskell | C++ | Java | Python  |
| ------ | ------ | ------ | ------ | ------ |
| Bootcamp: Primitive Types | countBits.hs | count\_bits.cc | CountBits.java | count\_bits.py | 
| Computing the parity of a word | parity.hs | parity.cc | Parity.java | parity.py | 
| Swap bits | swapBits.hs | swap\_bits.cc | SwapBits.java | swap\_bits.py | 
| Reverse bits | reverseBits.hs | reverse\_bits.cc | ReverseBits.java | reverse\_bits.py | 
| Find a closest integer with the same weight | closestIntSameWeight.hs | closest\_int\_same\_weight.cc | ClosestIntSameWeight.java | closest\_int\_same\_weight.py | 
| Compute x * y without arithmetical operators | primitiveMultiply.hs | primitive\_multiply.cc | PrimitiveMultiply.java | primitive\_multiply.py | 
| Compute x/y | primitiveDivide.hs | primitive\_divide.cc | PrimitiveDivide.java | primitive\_divide.py | 
| Compute x^y | powerXY.hs | power\_x\_y.cc | PowerXY.java | power\_x\_y.py | 
| Reverse digits | reverseDigits.hs | reverse\_digits.cc | ReverseDigits.java | reverse\_digits.py | 
| Check if a decimal integer is a palindrome | isNumberPalindromic.hs | is\_number\_palindromic.cc | IsNumberPalindromic.java | is\_number\_palindromic.py | 
| Generate uniform random numbers | uniformRandomNumber.hs | uniform\_random\_number.cc | UniformRandomNumber.java | uniform\_random\_number.py | 
| Rectangle intersection | rectangleIntersection.hs | rectangle\_intersection.cc | RectangleIntersection.java | rectangle\_intersection.py | 
| Bootcamp: Arrays | evenOddArray.hs | even\_odd\_array.cc | EvenOddArray.java | even\_odd\_array.py | 
| The Dutch national flag problem | dutchNationalFlag.hs | dutch\_national\_flag.cc | DutchNationalFlag.java | dutch\_national\_flag.py | 
| Increment an arbitrary-precision integer | intAsArrayIncrement.hs | int\_as\_array\_increment.cc | IntAsArrayIncrement.java | int\_as\_array\_increment.py | 
| Multiply two arbitrary-precision integers | intAsArrayMultiply.hs | int\_as\_array\_multiply.cc | IntAsArrayMultiply.java | int\_as\_array\_multiply.py | 
| Advancing through an array | advanceByOffsets.hs | advance\_by\_offsets.cc | AdvanceByOffsets.java | advance\_by\_offsets.py | 
| Delete duplicates from a sorted array | sortedArrayRemoveDups.hs | sorted\_array\_remove\_dups.cc | SortedArrayRemoveDups.java | sorted\_array\_remove\_dups.py | 
| Buy and sell a stock once | buyAndSellStock.hs | buy\_and\_sell\_stock.cc | BuyAndSellStock.java | buy\_and\_sell\_stock.py | 
| Buy and sell a stock twice | <TBA> | buy\_and\_sell\_stock\_twice.cc | BuyAndSellStockTwice.java | buy\_and\_sell\_stock\_twice.py | 
| Computing an alternation | <TBA> | alternating\_array.cc | AlternatingArray.java | alternating\_array.py | 
| Enumerate all primes to n | <TBA> | prime\_sieve.cc | PrimeSieve.java | prime\_sieve.py | 
| Permute the elements of an array | <TBA> | apply\_permutation.cc | ApplyPermutation.java | apply\_permutation.py | 
| Compute the next permutation | <TBA> | next\_permutation.cc | NextPermutation.java | next\_permutation.py | 
| Sample offline data | <TBA> | offline\_sampling.cc | OfflineSampling.java | offline\_sampling.py | 
| Sample online data | <TBA> | online\_sampling.cc | OnlineSampling.java | online\_sampling.py | 
| Compute a random permutation | <TBA> | random\_permutation.cc | RandomPermutation.java | random\_permutation.py | 
| Compute a random subset | <TBA> | random\_subset.cc | RandomSubset.java | random\_subset.py | 
| Generate nonuniform random numbers | <TBA> | nonuniform\_random\_number.cc | NonuniformRandomNumber.java | nonuniform\_random\_number.py | 
| The Sudoku checker problem | <TBA> | is\_valid\_sudoku.cc | IsValidSudoku.java | is\_valid\_sudoku.py | 
| Compute the spiral ordering of a 2D array | <TBA> | spiral\_ordering\_segments.cc | SpiralOrderingSegments.java | spiral\_ordering\_segments.py | 
| Rotate a 2D array | <TBA> | matrix\_rotation.cc | MatrixRotation.java | matrix\_rotation.py | 
| Compute rows in Pascal's Triangle | <TBA> | pascal\_triangle.cc | PascalTriangle.java | pascal\_triangle.py | 
| Interconvert strings and integers | <TBA> | string\_integer\_interconversion.cc | StringIntegerInterconversion.java | string\_integer\_interconversion.py | 
| Base conversion | <TBA> | convert\_base.cc | ConvertBase.java | convert\_base.py | 
| Compute the spreadsheet column encoding | <TBA> | spreadsheet\_encoding.cc | SpreadsheetEncoding.java | spreadsheet\_encoding.py | 
| Replace and remove | <TBA> | replace\_and\_remove.cc | ReplaceAndRemove.java | replace\_and\_remove.py | 
| Test palindromicity | <TBA> | is\_string\_palindromic\_punctuation.cc | IsStringPalindromicPunctuation.java | is\_string\_palindromic\_punctuation.py | 
| Reverse all the words in a sentence | <TBA> | reverse\_words.cc | ReverseWords.java | reverse\_words.py | 
| Compute all mnemonics for a phone number | <TBA> | phone\_number\_mnemonic.cc | PhoneNumberMnemonic.java | phone\_number\_mnemonic.py | 
| The look-and-say problem | <TBA> | look\_and\_say.cc | LookAndSay.java | look\_and\_say.py | 
| Convert from Roman to decimal | <TBA> | roman\_to\_integer.cc | RomanToInteger.java | roman\_to\_integer.py | 
| Compute all valid IP addresses | <TBA> | valid\_ip\_addresses.cc | ValidIpAddresses.java | valid\_ip\_addresses.py | 
| Write a string sinusoidally | <TBA> | snake\_string.cc | SnakeString.java | snake\_string.py | 
| Implement run-length encoding | <TBA> | run\_length\_compression.cc | RunLengthCompression.java | run\_length\_compression.py | 
| Find the first occurrence of a substring | <TBA> | substring\_match.cc | SubstringMatch.java | substring\_match.py | 
| Bootcamp: Linked Lists | <TBA> | search\_in\_list.cc | SearchInList.java | search\_in\_list.py | 
| Bootcamp: Linked Lists | <TBA> | insert\_in\_list.cc | InsertInList.java | insert\_in\_list.py | 
| Bootcamp: Linked Lists | <TBA> | delete\_from\_list.cc | DeleteFromList.java | delete\_from\_list.py | 
| Merge two sorted lists | <TBA> | sorted\_lists\_merge.cc | SortedListsMerge.java | sorted\_lists\_merge.py | 
| Reverse a single sublist | <TBA> | reverse\_sublist.cc | ReverseSublist.java | reverse\_sublist.py | 
| Test for cyclicity | <TBA> | is\_list\_cyclic.cc | IsListCyclic.java | is\_list\_cyclic.py | 
| Test for overlapping lists - lists are cycle-free | <TBA> | do\_terminated\_lists\_overlap.cc | DoTerminatedListsOverlap.java | do\_terminated\_lists\_overlap.py | 
| Test for overlapping lists - lists may have cycles | <TBA> | do\_lists\_overlap.cc | DoListsOverlap.java | do\_lists\_overlap.py | 
| Delete a node from a singly linked list | <TBA> | delete\_node\_from\_list.cc | DeleteNodeFromList.java | delete\_node\_from\_list.py | 
| Remove the kth last element from a list | <TBA> | delete\_kth\_last\_from\_list.cc | DeleteKthLastFromList.java | delete\_kth\_last\_from\_list.py | 
| Remove duplicates from a sorted list | <TBA> | remove\_duplicates\_from\_sorted\_list.cc | RemoveDuplicatesFromSortedList.java | remove\_duplicates\_from\_sorted\_list.py | 
| Implement cyclic right shift for singly linked lists | <TBA> | list\_cyclic\_right\_shift.cc | ListCyclicRightShift.java | list\_cyclic\_right\_shift.py | 
| Implement even-odd merge | <TBA> | even\_odd\_list\_merge.cc | EvenOddListMerge.java | even\_odd\_list\_merge.py | 
| Test whether a singly linked list is palindromic | <TBA> | is\_list\_palindromic.cc | IsListPalindromic.java | is\_list\_palindromic.py | 
| Implement list pivoting | <TBA> | pivot\_list.cc | PivotList.java | pivot\_list.py | 
| Add list-based integers | <TBA> | int\_as\_list\_add.cc | IntAsListAdd.java | int\_as\_list\_add.py | 
| Implement a stack with max API | <TBA> | stack\_with\_max.cc | StackWithMax.java | stack\_with\_max.py | 
| Evaluate RPN expressions | <TBA> | evaluate\_rpn.cc | EvaluateRpn.java | evaluate\_rpn.py | 
| Test a string over ''{,},(,),[,]'' for well-formedness | <TBA> | is\_valid\_parenthesization.cc | IsValidParenthesization.java | is\_valid\_parenthesization.py | 
| Normalize pathnames | <TBA> | directory\_path\_normalization.cc | DirectoryPathNormalization.java | directory\_path\_normalization.py | 
| Compute buildings with a sunset view | <TBA> | sunset\_view.cc | SunsetView.java | sunset\_view.py | 
| Compute binary tree nodes in order of increasing depth | <TBA> | tree\_level\_order.cc | TreeLevelOrder.java | tree\_level\_order.py | 
| Implement a circular queue | <TBA> | circular\_queue.cc | CircularQueue.java | circular\_queue.py | 
| Implement a queue using stacks | <TBA> | queue\_from\_stacks.cc | QueueFromStacks.java | queue\_from\_stacks.py | 
| Implement a queue with max API | <TBA> | queue\_with\_max.cc | QueueWithMax.java | queue\_with\_max.py | 
| Test if a binary tree is height-balanced | <TBA> | is\_tree\_balanced.cc | IsTreeBalanced.java | is\_tree\_balanced.py | 
| Test if a binary tree is symmetric | <TBA> | is\_tree\_symmetric.cc | IsTreeSymmetric.java | is\_tree\_symmetric.py | 
| Compute the lowest common ancestor in a binary tree | <TBA> | lowest\_common\_ancestor.cc | LowestCommonAncestor.java | lowest\_common\_ancestor.py | 
| Compute the LCA when nodes have parent pointers | <TBA> | lowest\_common\_ancestor\_with\_parent.cc | LowestCommonAncestorWithParent.java | lowest\_common\_ancestor\_with\_parent.py | 
| Sum the root-to-leaf paths in a binary tree | <TBA> | sum\_root\_to\_leaf.cc | SumRootToLeaf.java | sum\_root\_to\_leaf.py | 
| Find a root to leaf path with specified sum | <TBA> | path\_sum.cc | PathSum.java | path\_sum.py | 
| Implement an inorder traversal without recursion | <TBA> | tree\_inorder.cc | TreeInorder.java | tree\_inorder.py | 
| Implement a preorder traversal without recursion | <TBA> | tree\_preorder.cc | TreePreorder.java | tree\_preorder.py | 
| Compute the kth node in an inorder traversal | <TBA> | kth\_node\_in\_tree.cc | KthNodeInTree.java | kth\_node\_in\_tree.py | 
| Compute the successor | <TBA> | successor\_in\_tree.cc | SuccessorInTree.java | successor\_in\_tree.py | 
| Implement an inorder traversal with O(1) space | <TBA> | tree\_with\_parent\_inorder.cc | TreeWithParentInorder.java | tree\_with\_parent\_inorder.py | 
| Reconstruct a binary tree from traversal data | <TBA> | tree\_from\_preorder\_inorder.cc | TreeFromPreorderInorder.java | tree\_from\_preorder\_inorder.py | 
| Reconstruct a binary tree from a preorder traversal with markers | <TBA> | tree\_from\_preorder\_with\_null.cc | TreeFromPreorderWithNull.java | tree\_from\_preorder\_with\_null.py | 
| Form a linked list from the leaves of a binary tree | <TBA> | tree\_connect\_leaves.cc | TreeConnectLeaves.java | tree\_connect\_leaves.py | 
| Compute the exterior of a binary tree | <TBA> | tree\_exterior.cc | TreeExterior.java | tree\_exterior.py | 
| Compute the right sibling tree | <TBA> | tree\_right\_sibling.cc | TreeRightSibling.java | tree\_right\_sibling.py | 
| Merge sorted files | <TBA> | sorted\_arrays\_merge.cc | SortedArraysMerge.java | sorted\_arrays\_merge.py | 
| Sort an increasing-decreasing array | <TBA> | sort\_increasing\_decreasing\_array.cc | SortIncreasingDecreasingArray.java | sort\_increasing\_decreasing\_array.py | 
| Sort an almost-sorted array | <TBA> | sort\_almost\_sorted\_array.cc | SortAlmostSortedArray.java | sort\_almost\_sorted\_array.py | 
| Compute the k closest stars | <TBA> | k\_closest\_stars.cc | KClosestStars.java | k\_closest\_stars.py | 
| Compute the median of online data | <TBA> | online\_median.cc | OnlineMedian.java | online\_median.py | 
| Compute the k largest elements in a max-heap | <TBA> | k\_largest\_in\_heap.cc | KLargestInHeap.java | k\_largest\_in\_heap.py | 
| Search a sorted array for first occurrence of k | <TBA> | search\_first\_key.cc | SearchFirstKey.java | search\_first\_key.py | 
| Search a sorted array for entry equal to its index | <TBA> | search\_entry\_equal\_to\_index.cc | SearchEntryEqualToIndex.java | search\_entry\_equal\_to\_index.py | 
| Search a cyclically sorted array | <TBA> | search\_shifted\_sorted\_array.cc | SearchShiftedSortedArray.java | search\_shifted\_sorted\_array.py | 
| Compute the integer square root | <TBA> | int\_square\_root.cc | IntSquareRoot.java | int\_square\_root.py | 
| Compute the real square root | <TBA> | real\_square\_root.cc | RealSquareRoot.java | real\_square\_root.py | 
| Search in a 2D sorted array | <TBA> | search\_row\_col\_sorted\_matrix.cc | SearchRowColSortedMatrix.java | search\_row\_col\_sorted\_matrix.py | 
| Find the min and max simultaneously | <TBA> | search\_for\_min\_max\_in\_array.cc | SearchForMinMaxInArray.java | search\_for\_min\_max\_in\_array.py | 
| Find the kth largest element | <TBA> | kth\_largest\_in\_array.cc | KthLargestInArray.java | kth\_largest\_in\_array.py | 
| Find the missing IP address | <TBA> | absent\_value\_array.cc | AbsentValueArray.java | absent\_value\_array.py | 
| Find the duplicate and missing elements | <TBA> | search\_for\_missing\_element.cc | SearchForMissingElement.java | search\_for\_missing\_element.py | 
| Bootcamp: Hash Tables | <TBA> | anagrams.cc | Anagrams.java | anagrams.py | 
| Test for palindromic permutations | <TBA> | is\_string\_permutable\_to\_palindrome.cc | IsStringPermutableToPalindrome.java | is\_string\_permutable\_to\_palindrome.py | 
| Is an anonymous letter constructible? | <TBA> | is\_anonymous\_letter\_constructible.cc | IsAnonymousLetterConstructible.java | is\_anonymous\_letter\_constructible.py | 
| Implement an ISBN cache | <TBA> | lru\_cache.cc | LruCache.java | lru\_cache.py | 
| Compute the LCA, optimizing for close ancestors | <TBA> | lowest\_common\_ancestor\_close\_ancestor.cc | LowestCommonAncestorCloseAncestor.java | lowest\_common\_ancestor\_close\_ancestor.py | 
| Find the nearest repeated entries in an array | <TBA> | nearest\_repeated\_entries.cc | NearestRepeatedEntries.java | nearest\_repeated\_entries.py | 
| Find the smallest subarray covering all values | <TBA> | smallest\_subarray\_covering\_set.cc | SmallestSubarrayCoveringSet.java | smallest\_subarray\_covering\_set.py | 
| Find smallest subarray sequentially covering all values | <TBA> | smallest\_subarray\_covering\_all\_values.cc | SmallestSubarrayCoveringAllValues.java | smallest\_subarray\_covering\_all\_values.py | 
| Find the longest subarray with distinct entries | <TBA> | longest\_subarray\_with\_distinct\_values.cc | LongestSubarrayWithDistinctValues.java | longest\_subarray\_with\_distinct\_values.py | 
| Find the length of a longest contained interval | <TBA> | longest\_contained\_interval.cc | LongestContainedInterval.java | longest\_contained\_interval.py | 
| Compute all string decompositions | <TBA> | string\_decompositions\_into\_dictionary\_words.cc | StringDecompositionsIntoDictionaryWords.java | string\_decompositions\_into\_dictionary\_words.py | 
| Test the Collatz conjecture | <TBA> | collatz\_checker.cc | CollatzChecker.java | collatz\_checker.py | 
| Compute the intersection of two sorted arrays | <TBA> | intersect\_sorted\_arrays.cc | IntersectSortedArrays.java | intersect\_sorted\_arrays.py | 
| Merge two sorted arrays | <TBA> | two\_sorted\_arrays\_merge.cc | TwoSortedArraysMerge.java | two\_sorted\_arrays\_merge.py | 
| Computing the h-index | <TBA> | h\_index.cc | HIndex.java | h\_index.py | 
| Remove first-name duplicates | <TBA> | remove\_duplicates.cc | RemoveDuplicates.java | remove\_duplicates.py | 
| Smallest nonconstructible value | <TBA> | smallest\_nonconstructible\_value.cc | SmallestNonconstructibleValue.java | smallest\_nonconstructible\_value.py | 
| Render a calendar | <TBA> | calendar\_rendering.cc | CalendarRendering.java | calendar\_rendering.py | 
| Merging intervals | <TBA> | interval\_add.cc | IntervalAdd.java | interval\_add.py | 
| Compute the union of intervals | <TBA> | intervals\_union.cc | IntervalsUnion.java | intervals\_union.py | 
| Partitioning and sorting an array with many repeated entries | <TBA> | group\_equal\_entries.cc | GroupEqualEntries.java | group\_equal\_entries.py | 
| Team photo day - 1 | <TBA> | is\_array\_dominated.cc | IsArrayDominated.java | is\_array\_dominated.py | 
| Implement a fast sorting algorithm for lists | <TBA> | sort\_list.cc | SortList.java | sort\_list.py | 
| Compute a salary threshold | <TBA> | find\_salary\_threshold.cc | FindSalaryThreshold.java | find\_salary\_threshold.py | 
| Test if a binary tree satisfies the BST property | <TBA> | is\_tree\_a\_bst.cc | IsTreeABst.java | is\_tree\_a\_bst.py | 
| Find the first key greater than a given value in a BST | <TBA> | search\_first\_greater\_value\_in\_bst.cc | SearchFirstGreaterValueInBst.java | search\_first\_greater\_value\_in\_bst.py | 
| Find the k largest elements in a BST | <TBA> | k\_largest\_values\_in\_bst.cc | KLargestValuesInBst.java | k\_largest\_values\_in\_bst.py | 
| Compute the LCA in a BST | <TBA> | lowest\_common\_ancestor\_in\_bst.cc | LowestCommonAncestorInBst.java | lowest\_common\_ancestor\_in\_bst.py | 
| Reconstruct a BST from traversal data | <TBA> | bst\_from\_preorder.cc | BstFromPreorder.java | bst\_from\_preorder.py | 
| Find the closest entries in three sorted arrays | <TBA> | minimum\_distance\_3\_sorted\_arrays.cc | MinimumDistance3SortedArrays.java | minimum\_distance\_3\_sorted\_arrays.py | 
| Enumerate numbers of the form a + b sqrt(2) | <TBA> | a\_b\_sqrt2.cc | ABSqrt2.java | a\_b\_sqrt2.py | 
| Build a minimum height BST from a sorted array | <TBA> | bst\_from\_sorted\_array.cc | BstFromSortedArray.java | bst\_from\_sorted\_array.py | 
| Test if three BST nodes are totally ordered | <TBA> | descendant\_and\_ancestor\_in\_bst.cc | DescendantAndAncestorInBst.java | descendant\_and\_ancestor\_in\_bst.py | 
| The range lookup problem | <TBA> | range\_lookup\_in\_bst.cc | RangeLookupInBst.java | range\_lookup\_in\_bst.py | 
| Add credits | <TBA> | adding\_credits.cc | <TBA> | AddingCredits.java | adding\_credits.py | 
| The Towers of Hanoi problem | <TBA> | hanoi.cc | Hanoi.java | hanoi.py | 
| Generate all nonattacking placements of n-Queens | <TBA> | n\_queens.cc | NQueens.java | n\_queens.py | 
| Generate permutations | <TBA> | permutations.cc | Permutations.java | permutations.py | 
| Generate the power set | <TBA> | power\_set.cc | PowerSet.java | power\_set.py | 
| Generate all subsets of size k | <TBA> | combinations.cc | Combinations.java | combinations.py | 
| Generate strings of matched parens | <TBA> | enumerate\_balanced\_parentheses.cc | EnumerateBalancedParentheses.java | enumerate\_balanced\_parentheses.py | 
| Generate palindromic decompositions | <TBA> | enumerate\_palindromic\_decompositions.cc | EnumeratePalindromicDecompositions.java | enumerate\_palindromic\_decompositions.py | 
| Generate binary trees | <TBA> | enumerate\_trees.cc | EnumerateTrees.java | enumerate\_trees.py | 
| Implement a Sudoku solver | <TBA> | sudoku\_solve.cc | SudokuSolve.java | sudoku\_solve.py | 
| Compute a Gray code | <TBA> | gray\_code.cc | GrayCode.java | gray\_code.py | 
| Bootcamp: Dynamic Programming | <TBA> | fibonacci.cc | Fibonacci.java | fibonacci.py | 
| Bootcamp: Dynamic Programming | <TBA> | max\_sum\_subarray.cc | MaxSumSubarray.java | max\_sum\_subarray.py | 
| Count the number of score combinations | <TBA> | number\_of\_score\_combinations.cc | NumberOfScoreCombinations.java | number\_of\_score\_combinations.py | 
| Compute the Levenshtein distance | <TBA> | levenshtein\_distance.cc | LevenshteinDistance.java | levenshtein\_distance.py | 
| Count the number of ways to traverse a 2D array | <TBA> | number\_of\_traversals\_matrix.cc | NumberOfTraversalsMatrix.java | number\_of\_traversals\_matrix.py | 
| Compute the binomial coefficients | <TBA> | binomial\_coefficients.cc | BinomialCoefficients.java | binomial\_coefficients.py | 
| Search for a sequence in a 2D array | <TBA> | is\_string\_in\_matrix.cc | IsStringInMatrix.java | is\_string\_in\_matrix.py | 
| The knapsack problem | <TBA> | knapsack.cc | Knapsack.java | knapsack.py | 
| The bedbathandbeyond.com problem | <TBA> | is\_string\_decomposable\_into\_words.cc | IsStringDecomposableIntoWords.java | is\_string\_decomposable\_into\_words.py | 
| Find the minimum weight path in a triangle | <TBA> | minimum\_weight\_path\_in\_a\_triangle.cc | MinimumWeightPathInATriangle.java | minimum\_weight\_path\_in\_a\_triangle.py | 
| Pick up coins for maximum gain | <TBA> | picking\_up\_coins.cc | PickingUpCoins.java | picking\_up\_coins.py | 
| Count the number of moves to climb stairs | <TBA> | number\_of\_traversals\_staircase.cc | NumberOfTraversalsStaircase.java | number\_of\_traversals\_staircase.py | 
| The pretty printing problem | <TBA> | pretty\_printing.cc | PrettyPrinting.java | pretty\_printing.py | 
| Find the longest nondecreasing subsequence | <TBA> | longest\_nondecreasing\_subsequence.cc | LongestNondecreasingSubsequence.java | longest\_nondecreasing\_subsequence.py | 
| Compute an optimum assignment of tasks | <TBA> | task\_pairing.cc | TaskPairing.java | task\_pairing.py | 
| Schedule to minimize waiting time | <TBA> | minimum\_waiting\_time.cc | MinimumWaitingTime.java | minimum\_waiting\_time.py | 
| The interval covering problem | <TBA> | minimum\_points\_covering\_intervals.cc | MinimumPointsCoveringIntervals.java | minimum\_points\_covering\_intervals.py | 
| The interval covering problem | <TBA> | two\_sum.cc | TwoSum.java | two\_sum.py | 
| The 3-sum problem | <TBA> | three\_sum.cc | ThreeSum.java | three\_sum.py | 
| Find the majority element | <TBA> | majority\_element.cc | MajorityElement.java | majority\_element.py | 
| The gasup problem | <TBA> | refueling\_schedule.cc | RefuelingSchedule.java | refueling\_schedule.py | 
| Compute the maximum water trapped by a pair of vertical lines | <TBA> | max\_trapped\_water.cc | MaxTrappedWater.java | max\_trapped\_water.py | 
| Compute the largest rectangle under the skyline | <TBA> | largest\_rectangle\_under\_skyline.cc | LargestRectangleUnderSkyline.java | largest\_rectangle\_under\_skyline.py | 
| Search a maze | <TBA> | search\_maze.cc | SearchMaze.java | search\_maze.py | 
| Paint a Boolean matrix | <TBA> | matrix\_connected\_regions.cc | MatrixConnectedRegions.java | matrix\_connected\_regions.py | 
| Compute enclosed regions | <TBA> | matrix\_enclosed\_regions.cc | MatrixEnclosedRegions.java | matrix\_enclosed\_regions.py | 
| Deadlock detection | <TBA> | deadlock\_detection.cc | DeadlockDetection.java | deadlock\_detection.py | 
| Clone a graph | <TBA> | graph\_clone.cc | GraphClone.java | graph\_clone.py | 
| Making wired connections | <TBA> | is\_circuit\_wirable.cc | IsCircuitWirable.java | is\_circuit\_wirable.py | 
| Transform one string to another | <TBA> | string\_transformability.cc | StringTransformability.java | string\_transformability.py | 
| Team photo day - 2 | <TBA> | max\_teams\_in\_photograph.cc | MaxTeamsInPhotograph.java | max\_teams\_in\_photograph.py | 
| Compute the greatest common divisor | <TBA> | gcd.cc | Gcd.java | gcd.py | 
| Find the first missing positive entry | <TBA> | first\_missing\_positive\_entry.cc | FirstMissingPositiveEntry.java | first\_missing\_positive\_entry.py | 
| Buy and sell a stock k times | <TBA> | buy\_and\_sell\_stock\_k\_times.cc | BuyAndSellStockKTimes.java | buy\_and\_sell\_stock\_k\_times.py | 
| Compute the maximum product of all entries but one | <TBA> | max\_product\_all\_but\_one.cc | MaxProductAllButOne.java | max\_product\_all\_but\_one.py | 
| Compute the longest contiguous increasing subarray | <TBA> | longest\_increasing\_subarray.cc | LongestIncreasingSubarray.java | longest\_increasing\_subarray.py | 
| Rotate an array | <TBA> | rotate\_array.cc | RotateArray.java | rotate\_array.py | 
| Identify positions attacked by rooks | <TBA> | rook\_attack.cc | RookAttack.java | rook\_attack.py | 
| Justify text | <TBA> | left\_right\_justify\_text.cc | LeftRightJustifyText.java | left\_right\_justify\_text.py | 
| Implement list zipping | <TBA> | zip\_list.cc | ZipList.java | zip\_list.py | 
| Copy a postings list | <TBA> | copy\_posting\_list.cc | CopyPostingList.java | copy\_posting\_list.py | 
| Compute the longest substring with matching parens | <TBA> | longest\_substring\_with\_matching\_parentheses.cc | LongestSubstringWithMatchingParentheses.java | longest\_substring\_with\_matching\_parentheses.py | 
| Compute the maximum of a sliding window | <TBA> | max\_of\_sliding\_window.cc | MaxOfSlidingWindow.java | max\_of\_sliding\_window.py | 
| Implement a postorder traversal without recursion | <TBA> | tree\_postorder.cc | TreePostorder.java | tree\_postorder.py | 
| Compute fair bonuses | <TBA> | bonus.cc | Bonus.java | bonus.py | 
| Search a sorted array of unknown length | <TBA> | search\_unknown\_length\_array.cc | SearchUnknownLengthArray.java | search\_unknown\_length\_array.py | 
| Search in two sorted arrays | <TBA> | kth\_largest\_element\_in\_two\_sorted\_arrays.cc | KthLargestElementInTwoSortedArrays.java | kth\_largest\_element\_in\_two\_sorted\_arrays.py | 
| Find the kth largest element - large n, small k | <TBA> | kth\_largest\_element\_in\_long\_array.cc | KthLargestElementInLongArray.java | kth\_largest\_element\_in\_long\_array.py | 
| Find an element that appears only once | <TBA> | element\_appearing\_once.cc | ElementAppearingOnce.java | element\_appearing\_once.py | 
| Find the line through the most points | <TBA> | line\_through\_most\_points.cc | LineThroughMostPoints.java | line\_through\_most\_points.py | 
| Convert a sorted doubly linked list into a BST | <TBA> | sorted\_list\_to\_bst.cc | SortedListToBst.java | sorted\_list\_to\_bst.py | 
| Convert a BST to a sorted doubly linked list | <TBA> | bst\_to\_sorted\_list.cc | BstToSortedList.java | bst\_to\_sorted\_list.py | 
| Merge two BSTs | <TBA> | bst\_merge.cc | BstMerge.java | bst\_merge.py | 
| Implement regular expression matching | <TBA> | regular\_expression.cc | RegularExpression.java | regular\_expression.py | 
| Synthesize an expression | <TBA> | insert\_operators\_in\_string.cc | InsertOperatorsInString.java | insert\_operators\_in\_string.py | 
| Count inversions | <TBA> | count\_inversions.cc | CountInversions.java | count\_inversions.py | 
| Draw the skyline | <TBA> | drawing\_skyline.cc | DrawingSkyline.java | drawing\_skyline.py | 
| Measure with defective jugs | <TBA> | defective\_jugs.cc | DefectiveJugs.java | defective\_jugs.py | 
| Compute the maximum subarray sum in a circular array | <TBA> | maximum\_subarray\_in\_circular\_array.cc | MaximumSubarrayInCircularArray.java | maximum\_subarray\_in\_circular\_array.py | 
| Determine the critical height | <TBA> | max\_safe\_height.cc | MaxSafeHeight.java | max\_safe\_height.py | 
| Find the maximum 2D subarray | <TBA> | max\_submatrix.cc | MaxSubmatrix.java | max\_submatrix.py | 
| Find the maximum 2D subarray | <TBA> | max\_square\_submatrix.cc | MaxSquareSubmatrix.java | max\_square\_submatrix.py | 
| Implement Huffman coding | <TBA> | huffman\_coding.cc | HuffmanCoding.java | huffman\_coding.py | 
| Trapping water | <TBA> | max\_water\_trappable.cc | MaxWaterTrappable.java | max\_water\_trappable.py | 
| The heavy hitter problem | <TBA> | search\_frequent\_items.cc | SearchFrequentItems.java | search\_frequent\_items.py | 
| Find the longest subarray whose sum <=  k | <TBA> | longest\_subarray\_with\_sum\_constraint.cc | LongestSubarrayWithSumConstraint.java | longest\_subarray\_with\_sum\_constraint.py | 
| Road network | <TBA> | road\_network.cc | RoadNetwork.java | road\_network.py | 
| Test if arbitrage is possible | <TBA> | arbitrage.cc | Arbitrage.java | arbitrage.py | 

## Acknowledgments

A big shout-out to the hundreds of users who tried out the release over the past couple of months. As always, we never fail to be impressed by the enthusiasm and commitment our readers have; it has served to bring out the best in us.
We all thank [Viacheslav Kroilov](https://github.com/metopa), for applying his exceptional software engineering skills to make EPI Judge a reality.
