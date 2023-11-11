
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
verticalWin:: Color -> Column -> Bool
verticalWin Red col = aux col 0
    where aux _ 4 = True
          aux [] num = False
          aux (Red:xs) num = aux xs (num + 1)
          aux (Yellow:xs) num = aux xs 0
verticalWin Yellow col = aux col 0
    where aux _ 4 = True
          aux [] num = False
          aux (Yellow:xs) num = aux xs (num + 1)
          aux (Red:xs) num = aux xs 0



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
    where aux _ _ _ _ = False
          aux (w:ws) (x:xs) (y:ys) (z:zs) = 
            all (==col) [w,x,y,z] || aux ws xs ys zs

digonalWintoRight col colums = False

diagonalWinLeft :: Color -> Board -> Bool
diagonalWinLeft col (w:x:y:z:as) =
    aux (drop 3 $ reverse w) (drop 2 $ reverse x) (drop 1 $ reverse y) (reverse z)
    || diagonalWinLeft col (x:y:z:as)
    where aux _ _ _ _ = False
          aux (w:ws) (x:xs) (y:ys) (z:zs) = 
            all (==col) [w,x,y,z] || aux ws xs ys zs

digonalWintoLeft col colums = False

opposite :: Color -> Color
opposite Red = Yellow
opposite Yellow = Red

findWinner :: Game -> Maybe Winner
findWinner _ = Nothing
findWinner (board, currentPlayer) 
        | (verticalWin (opposite currentPlayer) board) == True = Just $ Winner opposite currentPlayer
        | (horizonalWinBoard (opposite currentPlayer) board) == True = Just $ Winner opposite currentPlayer
        | (diagonalWinLeft (opposite currentPlayer) board) == True = Just $ Winner opposite currentPlayer
        | (diagonalWintoRight (opposite currentPlayer) board) == True = Just $ Winner opposite currentPlayer
        | (verticalWin (currentPlayer) board) == True = Just $ Winner currentPlayer
        | (horizonalWinBoard (currentPlayer) board) == True = Just $ Winner currentPlayer
        | (diagonalWinLeft (currentPlayer) board) == True = Just $ Winner currentPlayer
        | (diagonalWintoRight (currentPlayer) board) == True = Just $ Winner currentPlayer
        | otherwise  = Just Tie
    --where currentPlayer == Red 

    
    



    --    if (verticalWin (opposite player) board) then Winner (opposite player) else Tie



    --case board of
    --[] -> Just $ Win Yellow
    --[]-> Just $ Win Red
    --[] -> Just $ Tie


updateBoard :: Game -> Move -> Game
updateBoard = undefined

allowedMoves :: Game -> [Move]
allowedMoves = undefined

showBoard :: Game -> String
showBoard = undefined
