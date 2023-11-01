import Data.List
--Data
data Color = Yellow | Red deriving (Show, Eq)
data Winner = Tie | Win Color deriving (Show, Eq)



-- Type Aliases
--
type Column = [Color]

--not sure if we want to just have a 
type Board = [Column]
type Move = Int

-- Idea is to have board and which player's turn it is (maybe include number of moves?)
type Game = (Board, Color)


-- Functions
--
findWinner :: Game -> Maybe Winner
findWinner = undefined

updateBoard :: Game -> Move -> Game
updateBoard = undefined

allowedMoves :: Game -> [Move]
allowedMoves = undefined

showCell :: Color -> String
showCell Yellow = "[y]"
showCell Red = "[r]"
showCell _ = "[ ]"

showBoard :: Game -> String
showBoard (board, currentPlayer) = unlines (header : rowStrings)
  where
    header = "  1  2  3  4  5  6  7"
    rowStrings = map (intercalate "|" . map (showCell)) boardRows
    boardRows = take 6 (transpose (map (take 6) board ++ repeat []))

