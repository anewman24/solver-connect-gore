
module Solver where
import Data.List
import Data.Maybe
import GameMechanics


whoWillWin :: Game -> Winner -- checks the current state of the game, if there is no winner or tie it passes through oneMoveAway
whoWillWin game@(board, turn) =
   case (findWinner game) of
        Just outcome -> outcome
        Nothing -> 
          let possibleResults =  [whoWillWin game | game <- catMaybes (possibleBoards game)] -- all possible boards a player can make. whoWillWin is called on each of them 
          in if Win turn `elem` possibleResults -- if there is a win for the player, it returns that
              then Win turn
              else 
                  if Tie `elem` possibleResults -- if not, then checks for a tie
                then Tie
                else Win (opposite turn) -- if not, then the other player is the infered winner 
                

possibleBoards :: Game -> [Maybe Game] -- takes a game creates a list of maybe games with all possible moves in the original game state
possibleBoards game = 
  [updateBoard game moves | moves <- validmoves]
      where validmoves = allowedMoves game


-- best move is supposed to force a win for the player or force a tie 


liftMaybe :: (Maybe a, b) -> Maybe (a,b)
liftMaybe (Nothing, x) = Nothing 
lifeMaybe (Just x, y) = Just (x,y)

bestMove :: Game -> Maybe Move
bestMove game@(board,turn) =
  case findWinner game of
    Just outcome -> Nothing
    Nothing ->
      let boardMoves = catMaybes [liftMaybe (updateBoard game move, move) | move <- allowedMoves game] -- all hypothetical boards w moves (tuple)
          movesCanMake = allowedMoves game
          possibleResults =  [(whoWillWin game, move) | (game,move) <- boardMoves] -- list of maybe winners and ties from hypothetical boards
        in case lookup (Win turn) possibleResults of  
                Just move -> Just move
                Nothing -> 
                  case lookup Tie possibleResults of 
                    Just move -> Just move
                    Nothing -> Just (snd(head possibleResults))
