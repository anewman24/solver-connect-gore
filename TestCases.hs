module TestCases where
  import Solver


--column test? 6 colors in a column (0-5)
emptyColumn = []
column1 = [Red, Yellow, Yellow, Red, Red, Red]
column2 = [Yellow, Yellow, Red, Red, Yellow, Yellow]
badcolumn = [Yellow, Red, Red, Yellow, Yellow, Red, Red]
almostcolumn = [Red, Yellow, Red, Red]


--board tests? 7 columns in a board
emptyBoard = [[]]
--or emptyBoard = []
board1 = [column1, column2, column2, column1 almostcolumn,column1, column2]
badBoard = [column1, column2, badcolumn, column1, almostcolumn, column2 badcolumn]

--move
begmove = 1
midmove = 21
mostmoves= 42
