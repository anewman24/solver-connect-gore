
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



horizonalWinBoard :: Color -> Column -> Column -> Column -> Column -> Bool
horizonalWinBoard Red (w:x:y:z:as) = aux (w:x:y:z:as) 0
    where aux (w:x:y:z:as) 4 = True
          aux [] num = False
          aux  (w:x:y:z:as) num = 
            aux (reverse w) (reverse x) (reverse y) (reverse z) (num + 1) 
            aux (reverse x) (reverse y) (reverse z) (reverse as) 0

horizonalWinBoard Yellow board totalnum = aux board 0
    where aux board 4 = True
          aux [[]] totalnum = False
          aux ((x:xs):ys) num = 
            if x == Yellow
                then aux ys (totalnum + 1)
                else aux ys 0
          

digonalWin :: Color -> Board -> Int -> Bool
digonalWin = undefined


findWinner :: Game -> Maybe Winner
findWinner _ = Nothing
findWinner (board, currentPlayer) = 
    where board = ((x:xs):ys)
    if currentPlayer == Red 
        then verticalWin Yellow (x:xs) || horizonalWinBoard Yellow ((x:xs):ys) || digonalWin Yellow ((x:xs):ys)
        else verticalWin Red (x:xs) || horizonalWinBoard Red ((x:xs):ys) || digonalWin Red ((x:xs):ys)


   
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
