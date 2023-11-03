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

makeNewBoard :: Board -> Move -> Color -> Board
makeNewBoard board move color = 
    let (left, (b:bs)) = splitAt move board
        edited = [color:b]
    in left ++ edited ++ bs

updateBoard :: Game -> Move -> Maybe Game
-- check if move is allowed, add Color to Column(indicated by move) create new game with respective Color and updated Board
updateBoard game move =
    if move `elem` (allowedMoves game)
    then let (board, color) = game
             newBoard = makeNewBoard board move color
         in Just (newBoard, swapColor color)
    else Nothing

sampleboard = ([[Red, Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow, Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow, Red, Red,Yellow],[]],Red)

allowedMoves :: Game -> [Move]
allowedMoves (b,c) = let spotsLeft = [6 - (length col)|col <-b]
                         zipSpots = zip (spotsLeft) [0..6]
                        in 
                           [col | (left,col) <- zipSpots, left /= 0]  

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

