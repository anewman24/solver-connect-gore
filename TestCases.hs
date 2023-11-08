module TestCases where 
  import Solver

{- 
data Color = Empty | Yellow | Red deriving (Show, Eq)
data Winner = Tie | Win Color deriving (Show, Eq)
-}

--type Column = [Color] 6 colors in a column (0-5)
emptyColumn = []
column1 = [Red, Yellow, Yellow, Red, Red, Red]
column2 = [Yellow, Yellow, Red, Red, Yellow, Yellow]
badcolumn = [Yellow, Red, Red, Yellow, Yellow, Red, Red]
almostcolumn = [Red, Yellow, Red, Red, Empty, Empty]



--type Board = [Column] 7 columns in a board
emptyBoard = [[]]
--or emptyBoard = []
board1 = [column1, column2, column2, column1 almostcolumn,column1, column2]
badBoard = [column1, column2, badcolumn, column1, almostcolumn, column2 badcolumn]
sampleboard = ([[Red, Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow, Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow, Red, Red,Yellow],[]],Red)


otherboard = ([[Red,Yellow],[Red,Red,Red,Red,Red],[Empty],[Yellow,Yellow,Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow,Red,Red,Yellow],[Empty]],Red)


--type Move = Int
begmove = 1
midmove = 21
mostmoves= 42


-- Idea is to have board and which player's turn it is (maybe include number of moves?)
--type Game = (Board, Color)
gametime = (emptyBoard, Red)
games = (board1, Yellow)
sampleGame = (sampleboard, Yellow)

-- Functions


--findWinner :: Game -> Maybe Winner
findWinner sampleGame

--swapColor :: Color -> Color
swapColor Red
swapColor Yellow

--Takes a board, a move, and a color and returns a updated board
--makeNewBoard :: Board -> Move -> Color -> Board
makeNewBoard board1 midmove Red
makeNewBoard emptyBoard begmove Yellow

--Given a Game and a Move, creates a new Game with the result of the given Move. Will return a new Game or if the Move is not valid; will return Nothing.
--updateBoard :: Game -> Move -> Game
updateBoard gametime begmove
updateBoard sampleGame 11


--Creates a list of possible moves, returns a list of the 
--allowedMoves :: Game -> [Move]
allowedMoves gametime
allowedMoves games
allowedMoves sampleGame


--Converts a Color type into its String representation
--showCell :: Color -> String
showCell Yellow
showCell Red

--showBoard :: Game -> String
showBoard gametime
showBoard games

--padColumns :: Int -> Board -> Board


--padTo :: Int -> [Color] -> [Color]
