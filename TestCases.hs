module TestCases where
  import Solver

{- 
data Color = Yellow | Red deriving (Show, Eq)
data Winner = Tie | Win Color deriving (Show, Eq)
-}

--type Column = [Color] 6 colors in a column (0-5)
emptyColumn = []
column1 = [Red, Yellow, Yellow, Red, Red, Red]
column2 = [Yellow, Yellow, Red, Red, Yellow, Yellow]
badcolumn = [Yellow, Red, Red, Yellow, Yellow, Red, Red]
almostcolumn = [Red, Yellow, Red, Red]



--type Board = [Column] 7 columns in a board
emptyBoard = [[]]
--or emptyBoard = []
board1 = [column1, column2, column2, column1 almostcolumn,column1, column2]
badBoard = [column1, column2, badcolumn, column1, almostcolumn, column2 badcolumn]


--type Move = Int
begmove = 1
midmove = 21
mostmoves= 42


-- Idea is to have board and which player's turn it is (maybe include number of moves?)
--type Game = (Board, Color)
gametime = (board1, Red)


-- Functions


--findWinner :: Game -> Maybe Winner

--updateBoard :: Game -> Move -> Game


--allowedMoves :: Game -> [Move]


--showBoard :: Game -> String







