import Data.List

--Data
-- Color represents which color the move is. It also acts as the signifier for the player
data Color = Yellow | Red deriving (Show, Eq)

-- Winner is the two main possible outcomes: when the game is a tie and when one of the players wins 
data Winner = Tie | Win Color deriving (Show, Eq)


-- Type Aliases

-- Column will have 6 colors at max and represents an individual column in the game
type Column = [Color]

-- Board will have 7 columns at max and each can be accessed with the respective number 0-6
type Board = [Column]

-- Move represents the index of the column to be accessed, will be between 0 and 6 
type Move = Int

-- Idea is to have board and which player's turn it is (maybe include number of moves?)
type Game = (Board, Color)

sampleboard = ([[Red, Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow, Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow, Red, Red,Yellow],[]],Red)

-- Functions
--
findWinner :: Game -> Maybe Winner
findWinner = undefined

-- Takes a color and returns the opposite color
swapColor :: Color -> Color
swapColor Red = Yellow
swapColor Yellow = Red

-- Takes a board, a move, and a color and returns a updates board
makeNewBoard :: Board -> Move -> Color -> Board
makeNewBoard board move color = 
    let (left, (b:bs)) = splitAt move board
        edited = [color:b]
    in left ++ edited ++ bs

-- Given a Game and a Move, creates a new Game with the result of the given Move. Will return a new Game or if the Move is not valid; will return Nothing.
updateBoard :: Game -> Move -> Maybe Game
updateBoard game move =
    if move `elem` (allowedMoves game)
    then let (board, color) = game
             newBoard = makeNewBoard board move color
         in Just (newBoard, swapColor color)
    else Nothing

-- Creates a list of possible moves, returns a list of the 
allowedMoves :: Game -> [Move]
allowedMoves (b,c) = let spotsLeft = [6 - (length col)|col <-b]
                         zipSpots = zip (spotsLeft) [0..6]
                        in 
                           [col | (left,col) <- zipSpots, left /= 0]  

-- Converts a Color type into its String representation
showCell :: Color -> String
showCell Yellow = "[y]"
showCell Red = "[r]"
showCell _ = "[ ]"

-- Converts a given game into a string that can print onto GHCI or cmd line
showBoard :: Game -> String
showBoard (board, currentPlayer) = unlines (header : rowStrings)
  where
    header = "  1  2  3  4  5  6  7"
    rowStrings = map (intercalate "|" . map (showCell)) boardRows
    boardRows = take 6 (transpose (map (take 6) board ++ repeat []))

