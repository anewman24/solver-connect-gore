module TestCases where 
  import GameMechanics
  import TestInputs

{- 
data Color = Yellow | Red deriving (Show, Eq)
data Winner = Tie | Win Color deriving (Show, Eq)
-}

--type Column = [Color] // 6 colors in a column (0-5)

--type Board = [Column] //  7 columns in a board
emptyBoard = [[]]
sampleBoard = [[Red, Yellow], [Red,Red,Yellow,Yellow,Red], [], [Red,Red,Red,Yellow,Yellow,Yellow], [Red,Red,Red], [Yellow, Red, Red,Yellow], []]



--type Move = Int // for each column

--type Game = (Board, Color)

sampleGame = (sampleBoard, Red)
newGame = (emptyBoard, Red)


-- -- -- --  Functions

--verticalWinBoard :: Color -> Board -> Bool


--winAcross :: Color -> Board -> Bool

-- When given a game, will find a winner or tie if there is one, or will return Nothing if not
--findWinner :: Game -> Maybe Winner


-- Takes a color and returns the opposite color
--swapColor :: Color -> Color
swapColor Red
swapColor Yellow

--Takes a board, a move, and a color and returns a updated board
--makeNewBoard :: Board -> Move -> Color -> Board

--Given a Game and a Move, creates a new Game with the result of the given Move. Will return a new Game or if the Move is not valid; will return Nothing.
--updateBoard :: Game -> Move -> Game


--Creates a list of possible moves, returns a list of the 
--allowedMoves :: Game -> [Move]


--Converts a Color type into its String representation
--showCell :: Color -> String
showCell Yellow
showCell Red

--showBoard :: Game -> String


--padColumns :: Int -> Board -> Board


--padTo :: Int -> [Color] -> [Color]
