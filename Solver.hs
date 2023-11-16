
module Solver where 
import Data.List


--Data
-- Color represents which color the move is. It also acts as the signifier for the player
data Color = Yellow | Red deriving (Show, Eq)

-- Winner is the two main possible outcomes: when the game is a tie and when one of the players wins 
data Winner = Tie | Win Color deriving (Show, Eq)


-- Type Aliases

-- Column will have 6 colors at max and represents an individual column in the game
type Column = [Color]
sampleColumn1 = [Red, Yellow]
sampleColumn2 = [Red,Red,Red,Red,Red]
sampleColumn3 = []
sampleColumn4 = [Yellow,Yellow, Yellow,Yellow,Yellow,Yellow]
sampleColumn5 = [Red,Red,Red]
sampleColumn6 = [Yellow, Red, Red,Yellow]
sampleColumn7 = []

-- Board will have 7 columns at max and each can be accessed with the respective number 0-6
type Board = [Column]

sampleboard = [sampleColumn1, sampleColumn2, sampleColumn3, sampleColumn4, sampleColumn5, sampleColumn6, sampleColumn7]
emptyboard = [[]]



-- Move represents the index of the column to be accessed, will be between 0 and 6 
type Move = Int

-- Idea is to have board and which player's turn it is (maybe include number of moves?)
type Game = (Board, Color)
sampleGame = (sampleboard, Red)
startGame = (emptyboard, Red)

--otherboard = ([[Red,Yellow],[Red,Red,Red,Red,Red],[Empty],[Yellow,Yellow,Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow,Red,Red,Yellow],[Empty]],Red)


board2 = ([[Red, Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow, Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow, Red, Red,Yellow],[]],Red)
otherboard = ([[Red,Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow,Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow,Red,Red,Yellow],[]],Red)


-- when printing (such as in ghci) use putStrLn (showBoard <board>)

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

-- Creates a list of possible moves, returns a list of the legal moves
allowedMoves :: Game -> [Move]
allowedMoves (b,c) = let spotsLeft = [6 - (length col)|col <-b]
                         zipSpots = zip (spotsLeft) [0..6]
                        in 
                           [col | (left,col) <- zipSpots, left /= 0]  


{- allowedMoves sampleGame = [0, 1, 2, 4, 5, 6]
       I guess that means it works but what does it mean?
-}

-- Converts a Color type into its String representation
showCell :: Maybe Color -> String
showCell (Just Yellow) = "[y]"
showCell (Just Red) = "[r]"
showCell Nothing = "[ ]"

showBoard :: Game -> String
showBoard (board, currentPlayer) = unlines (header : rowStrings)
  where
    header = "  1  2  3  4  5  6  7"
    paddedBoard = padColumns 7 board
    rowStrings = map (intercalate "|" . map (showCell)) (transpose paddedBoard)

padColumns :: Int -> Board ->  [[Maybe Color]]
padColumns n board = map (padTo n) board

padTo :: Int -> [Color] -> [Maybe Color]
padTo n xs = take n (map Just xs ++ repeat Nothing)

