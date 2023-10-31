
--Data
data Color = Yellow | Red | Maybe Color
data Game = undefined


-- Type Aliases
--
type Column = [Color]
type Board = [Column]
type Move = (Integer, Color)
type Winner = undefined


-- Functions
--
findWinner :: Game -> Winner
findWinner = undefined

gameResult :: Game -> Move -> Game
gameResult = undefined

allowedMoves :: Game -> [Move]
allowedMoves = undefined

showBoard :: Game -> String
showBoard = undefined
