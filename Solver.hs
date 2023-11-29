module Solver where 
import Data.List
import GameMechanics

bestMove :: Game -> Move
bestMove game = 
	let (board, move) = game
    in case (findWinner game) of
        Just Tie -> 		
        Just Winner -> 
		Nothing -> 


