
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
    aux (reverse w) (reverse x) (reverse y) (reverse z) 
    || digonalWintoRight col (x:y:z:as)
    where aux [] [] [] [] = False
          aux (w:ws) (x:xs) (y:ys) (z:zs) = 
           all ( < 2) (length w && length x && length y && length z) 
           || aux (w:ws) (x1:x2:xs) (y1:y2:y3:ys) (z1:z2:z3:z4:zs)  
          aux (w:ws) (x1:x2:xs) (y1:y2:y3:ys) (z1:z2:z3:z4:zs) 
            = all (==col) [w,x2,y3,z4] || aux ws xs ys zs

digonalWintoRight col colums = False

diagonalWinLeft :: Color -> Board -> Bool
diagonalWinLeft = undefined


findWinner :: Game -> Maybe Winner
findWinner _ = Nothing
findWinner (board, currentPlayer) = undefined
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
