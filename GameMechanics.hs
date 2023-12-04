
module GameMechanics where 
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

board1 = [[],[Red],[Yellow,Red,Yellow,Red],[Red,Yellow,Yellow,Yellow,Red,Red],[Yellow,Yellow,Yellow,Yellow,Red,Yellow],[Red,Red,Yellow,Red,Red],[]]
--Vertical win for yellow on board 1
board2 = [[],[Yellow],[Red,Yellow,Red,Yellow],[Yellow,Red,Red,Red,Yellow,Yellow],[Red,Red,Red,Red,Yellow,Red],[Yellow,Yellow,Red,Yellow,Yellow],[]]
--Vertical win for Red on board 2 
board3 = [[],[Red],[Yellow,Red,Yellow,Red],[Yellow,Yellow,Yellow,Red,Red],[Yellow,Yellow,Yellow,Red,Yellow],[Red,Red,Yellow,Red,Red],[Red,Yellow]]
-- horizontal win for red on board 3
board4 =[[],[Yellow],[Red,Yellow,Red,Yellow],[Red,Red,Red,Yellow,Yellow],[Red,Red,Red,Yellow,Red],[Yellow,Yellow,Red,Yellow,Yellow],[Yellow,Red]]
-- horizontal win for yellow on board 4
board5 = [[],[Red],[Red,Yellow,Red,Yellow,Red],[Yellow,Yellow,Yellow,Red,Red],[Yellow,Yellow,Yellow,Red,Yellow],[Yellow,Red,Yellow,Red,Red],[]]
--diagonalWin for Yellow on board 5 (right diagonal)
board6 = [[],[Yellow],[Yellow,Red,Yellow,Red,Yellow],[Yellow,Red,Red,Red,Yellow,Yellow],[Red,Red,Red,Yellow,Red],[Red,Yellow,Red,Yellow,Yellow],[]]
--diagonalWin for Red on board 6 (right diagonal)
board7 = reverse board5
--diagonalWin for Yellow on board 7 (left diagonal)
board8 = reverse board6
--diagonalWin for Red on board 8 (left diagonal)
board9 = [[],[Yellow,Red],[Yellow,Red,Yellow,Red,Yellow,Red],[Red,Yellow,Yellow,Yellow,Red,Red],[Red,Yellow,Yellow,Red,Yellow],[Red,Red,Yellow,Red,Red],[]]
-- Tie test
board10 =[[],[Red],[Red,Yellow,Red,Yellow,Red],[Yellow,Yellow,Yellow,Red,Red],[Red,Yellow,Yellow,Red,Yellow],[Red,Red,Yellow,Red,Red],[]]
--Nothing Test


-- Move represents the index of the column to be accessed, will be between 0 and 6 
type Move = Int

-- Idea is to have board and which player's turn it is (maybe include number of moves?)
type Game = (Board, Color)


--otherboard = ([[Red,Yellow],[Red,Red,Red,Red,Red],[Empty],[Yellow,Yellow,Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow,Red,Red,Yellow],[Empty]],Red)




board11 = ([[Red, Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow, Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow, Red, Red,Yellow],[]],Red)
otherboard = ([[Red,Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow,Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow,Red,Red,Yellow],[]],Red)

sampleboard2 = ([[Red, Yellow],[Red,Red,Red,Red,Red],[],[Yellow,Yellow, Yellow,Yellow,Yellow,Yellow],[Red,Red,Red],[Yellow, Red, Red,Yellow],[]],Red)




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

verticalWinBoard color [] = False


winAcross :: Color -> Board -> Bool
winAcross col (w:x:y:z:as) = 
    aux (reverse w) (reverse x) (reverse y) (reverse z) --Horizontal check
    || aux (drop 3 $ reverse w) (drop 2 $ reverse x) (drop 1 $ reverse y) (reverse z) --Diagonal left check
    || aux (reverse w) (drop 1 $ reverse x) (drop 2 $ reverse y) (drop 3 $ reverse z) --Diagonal right check 
    || winAcross col (x:y:z:as)
    where aux (w:ws) (x:xs) (y:ys) (z:zs) = 
            all (==col) [w,x,y,z] || aux ws xs ys zs
          aux _ _ _ _ = False
          
winAcross color columns = False

opposite :: Color -> Color
opposite Red = Yellow
opposite Yellow =  Red

findWinner :: Game -> Maybe Winner
findWinner (board, currentPlayer) 
       | anyWin Red board = Just $ Win Red 
       | anyWin Yellow board = Just $ Win Yellow
       | null(allowedMoves (board,currentPlayer)) = Just $ Tie 
       | otherwise = Nothing
 
    
anyWin currentPlayer board = 
           verticalWinBoard currentPlayer board
        || winAcross currentPlayer board
    


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

--showBoard :: Game -> String
--showBoard (board, currentPlayer) = unlines (header : rowStrings)
  --where
    --header = "  1  2  3  4  5  6  7"
    --paddedBoard = padColumns 7 board
    --rowStrings = map (intercalate "|" . map (showCell)) (transpose paddedBoard)

padColumns :: Int -> Board ->  [[Maybe Color]]
padColumns n board = map (padTo n) board

padTo :: Int -> [Color] -> [Maybe Color]
padTo n xs = take n (map Just xs ++ repeat Nothing)


