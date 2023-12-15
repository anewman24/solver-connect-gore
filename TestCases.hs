module TestCases where 
import GameMechanics

{- 
data Color =  Yellow | Red deriving (Show, Eq)
data Winner = Tie | Win Color deriving (Show, Eq)
-}

--type Column = [Color] 6 colors in a column (0-5)

{-emptyColumn = []
column1 = [Red, Yellow, Yellow, Red, Red, Red]
column2 = [Yellow, Yellow, Red, Red, Yellow, Yellow]
badcolumn = [Yellow, Red, Red, Yellow, Yellow, Red, Red]
almostcolumn = [Red, Yellow, Red, Red, Empty, Empty]
-} 

sampleColumn1 = [Red, Yellow]
sampleColumn2 = [Red,Red,Red,Red,Red]
sampleColumn3 = []
sampleColumn4 = [Yellow,Yellow, Yellow,Yellow,Yellow,Yellow]
sampleColumn5 = [Red,Red,Red]
sampleColumn6 = [Yellow, Red, Red,Yellow]
sampleColumn7 = []



--type Board = [Column] 7 columns in a board
emptyBoard = []
sampleBoard = [[Yellow, Red, Red], [Red, Yellow, Red], [Red, Red], [Yellow, Yellow], [Yellow, Red, Yellow], [Yellow, Red], [Yellow]]
badBoard = [[Yellow, Yellow, Red, Red,Yellow, Red, Red],[Red, Yellow, Red], [Red, Red], [Yellow, Yellow], [Yellow, Red, Yellow], [Yellow, Red], [Yellow]] 


--type Board = [Column] //  7 columns in a board

sampleGame = (sampleBoard, Red)
startGame = (emptyBoard, Red)




-- -- -- --  Functions

--verticalWinBoard :: Color -> Board -> Bool


--winAcross :: Color -> Board -> Bool

-- When given a game, will find a winner or tie if there is one, or will return Nothing if not
--findWinner :: Game -> Maybe Winner

-- Takes a color and returns the opposite color
--swapColor :: Color -> Color
--swapColor Red
--swapColor Yellow

--Takes a board, a move, and a color and returns a updated board
--makeNewBoard :: Board -> Move -> Color -> Board

--Given a Game and a Move, creates a new Game with the result of the given Move. Will return a new Game or if the Move is not valid; will return Nothing.
--updateBoard :: Game -> Move -> Game


--Creates a list of possible moves, returns a list of the 
--allowedMoves :: Game -> [Move]


--Converts a Color type into its String representation
--showCell :: Color -> String

showCell Yellow = undefined
showCell Red  = undefined

--showBoard :: Game -> String
showBoard gametime = undefined


--padColumns :: Int -> Board -> Board


--padTo :: Int -> [Color] -> [Color]
