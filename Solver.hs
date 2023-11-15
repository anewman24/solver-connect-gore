
module Solver where 
import Data.List


--Data
-- Color represents which color the move is. It also acts as the signifier for the player
data Color = Empty | Yellow | Red deriving (Show, Eq)

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
move1 = 0
move2 = 1
move3 = 2
move4 = 3
move5 = 4
move6 = 5
move7 = 6

-- Idea is to have board and which player's turn it is (maybe include number of moves?)
type Game = (Board, Color)
sampleGame = (sampleboard, Red)
startGame = (emptyboard, Red)

--otherboard = ([[Red,Yellow],[Red,Red,Red,Red,Red],[Empty],[Yellow,Yellow,Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow,Red,Red,Yellow],[Empty]],Red)


--sampleboard = ([[Red, Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow, Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow, Red, Red,Yellow],[]],Red)
--otherboard = ([[Red,Yellow],[Red,Red,Red,Red,Red],[Empty],[Yellow,Yellow,Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow,Red,Red,Yellow],[Empty]],Red)


-- when printing (such as in ghci) use putStrLn (showBoard <board>)

-- Functions
--
verticalWinBoard :: Color -> Board -> Bool
verticalWinBoard color (a:as) = aux (reverse a) 0 
    || verticalWinBoard color as 
    where aux _ 4 = True
          aux [] num = False
          aux (x:xs) num 
            |x == color = aux xs (num + 1)
            |otherwise = aux xs 0 
          



horizonalWinBoard :: Color -> Board -> Bool
horizonalWinBoard col (w:x:y:z:as) =
    aux (reverse w) (reverse x) (reverse y) (reverse z)
    || horizonalWinBoard col (x:y:z:as)
    where aux [] [] [] [] = False
          aux (w:ws) (x:xs) (y:ys) (z:zs) =
            all (==col) [w,x,y,z] || aux ws xs ys zs

horizonalWinBoard col columns = False


digonalWintoRight :: Color -> Board -> Bool
digonalWintoRight col (w:x:y:z:as) = 
    aux (reverse w) (drop 1 $ reverse x) (drop 2 $ reverse y) (drop 3 $ reverse z) 
    || digonalWintoRight col (x:y:z:as)
    where aux (w:ws) (x:xs) (y:ys) (z:zs) = 
            all (==col) [w,x,y,z] || aux ws xs ys zs
          aux _ _ _ _ = False

digonalWintoRight col colums = False

diagonalWinLeft :: Color -> Board -> Bool
diagonalWinLeft col (w:x:y:z:as) =
    aux (drop 3 $ reverse w) (drop 2 $ reverse x) (drop 1 $ reverse y) (reverse z)
    || diagonalWinLeft col (x:y:z:as)
    where aux (w:ws) (x:xs) (y:ys) (z:zs) = 
            all (==col) [w,x,y,z] || aux ws xs ys zs
          aux _ _ _ _ = False

digonalWintoLeft col colums = False

opposite :: Color -> Color
opposite Red = Yellow
opposite Yellow =  Red

findWinner :: Game -> Maybe Winner
findWinner (board, currentPlayer) 
       | anyWin Red board = Just $ Win Red 
       | anyWin Yellow board = Just $ Win Yellow
       | otherwise = Just Tie
    
anyWin currentPlayer board = 
           verticalWinBoard currentPlayer board
        || horizonalWinBoard currentPlayer board 
        || diagonalWinLeft currentPlayer board 
        || digonalWintoRight currentPlayer board
    


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


{- allowedMoves sampleGame = [0, 1, 2, 4, 5, 6]
       I guess that means it works but what does it mean?
-}

-- Converts a Color type into its String representation
showCell :: Color -> String
showCell Yellow = "[y]"
showCell Red = "[r]"

showBoard :: Game -> String
showBoard (board, currentPlayer) = unlines (header : rowStrings)
  where
    header = "  1  2  3  4  5  6  7"
    paddedBoard = padColumns 7 board
    rowStrings = map (intercalate "|" . map (showCell)) (transpose paddedBoard)

padColumns :: Int -> Board -> Board
padColumns n board = map (padTo n) board

padTo :: Int -> [Color] -> [Color]
padTo n xs = take n (xs ++ repeat Empty)

