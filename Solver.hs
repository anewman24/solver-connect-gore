
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
verticalWinBoard :: Color -> Board -> Bool
verticalWinBoard color (a:as) = aux (reverse a) 0 
    || verticalWinBoard color as 
    where aux _ 4 = True
          aux [] num = False
          aux (x:xs) num 
            |x == color = aux xs (num + 1)
            |otherwise = aux xs 0 
          

-- verticalWin:: Color -> Column -> Bool
-- verticalWin Red col = aux col 0
    -- where aux _ 4 = True
          -- aux [] num = False
          -- aux (Red:xs) num = aux xs (num + 1)
          -- aux (Yellow:xs) num = aux xs 0
-- verticalWin Yellow col = aux col 0
    -- where aux _ 4 = True
          -- aux [] num = False
          -- aux (Yellow:xs) num = aux xs (num + 1)
          -- aux (Red:xs) num = aux xs 0



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
