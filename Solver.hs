
module Solver where 
import Data.List
import Data.Maybe
import GameMechanics


whoWillWin :: Game -> Winner 
whoWillWin game = case (findWinner game) of
        Just outcome -> outcome
        Nothing -> (oneMoveAway game)

oneMoveAway :: Game -> Winner     
oneMoveAway game@(board,turn) = 
    let possibleResults =  [whoWillWin game | game <- catMaybes (possibleBoards game)] -- a list with maybe winners (includes ties)
    in 
      if Win turn `elem` possibleResults
      then Win turn
      else Tie

possibleBoards :: Game -> [Maybe Game] -- takes a game creates a list of maybe games with all possible moves in the original game state
possibleBoards game = 
  [updateBoard game moves | moves <- validmoves]
      where validmoves = allowedMoves game