
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
horizonalWinBoard Red (w:x:y:z:as) = 
    (aux (reverse w) (reverse x) (reverse y) (reverse z)) 
    || aux (reverse x) (reverse y) (reverse z) reverse a <- (a:as)
    where aux [] [] [] [] = False
          aux (Red:ws) (Red:xs) (Red:ys) (Red:zs) = True
          aux (_:ws) (_:xs) (_:ys) (_:zs) = aux ws xs ys zs
            


--horizonalWinBoard Yellow board = aux board 
   --where aux board 4 = True
          --aux [[]] totalnum = False
          --aux ((x:xs):ys) num = 
            --if x == Yellow
                --then aux ys (totalnum + 1)
                --else aux ys 0
          

digonalWin :: Color -> Board -> Int -> Bool
digonalWin = undefined


findWinner :: Game -> Maybe Winner
findWinner _ = Nothing
findWinner (board, currentPlayer) = 
    if currentPlayer == Red 
        then verticalWin Yellow y || horizonalWinBoard Yellow (w:u:x:y:ys) || digonalWin Yellow (y:ys) 
        else verticalWin Red y || horizonalWinBoard Red (y:ys) || digonalWin Red (y:ys)


   
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
