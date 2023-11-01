import Data.List

--Data
data Color = Yellow | Red deriving (Show, Eq)
data Winner = Tie | Win Color deriving (Show, Eq)



-- Type Aliases
--
type Column = [Color]
type Board = [Column]
type Move = Int

-- Idea is to have board and which player's turn it is (maybe include number of moves?)
type Game = (Board, Color)

-- Functions
--
findWinner :: Game -> Maybe Winner
findWinner = undefined

swapColor :: Color -> Color
swapColor Red = Yellow
swapColor Yellow = Red

updateBoard :: Game -> Move -> Maybe Game
-- check if move is allowed, add Color to Column(indicated by move) create new game with respective Color and updated Board
updateBoard game move =
    if move `elem` (allowedMoves game)
    then let (board, color) = game
             (front, (b:bs)) = splitAt move board
             newBoard = front ++ (color:b:[]) ++ bs
         in Just (newBoard, swapColor color)
    else Nothing

allowedMoves :: Game -> [Move]
allowedMoves = undefined

showBoard :: Game -> String
showBoard = undefined
