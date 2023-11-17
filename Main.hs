module Main where
import Solver
import GameMechanics
--import TestCases

import System.Environment
import System.IO

main :: IO ()
main = undefined


--Computes the best move and prints it to standard output, also should return result of said game
putBestMove :: Game -> IO ()
putBestMove = undefined

--Writes a game state to a file
writeGame :: Game -> FilePath -> IO ()
writeGame game path = 
    do writeFile path (showGame game)

--Loads a file and reads a game state from it
loadGame :: FilePath -> IO Game
loadGame path = undefined
    --do contents <- (readFile path) -- gives whole file as a string
       --let (g:gs) = lines contents -- creates a list where each newline is a string
       --in 



readGame :: String -> Game
readGame = undefined

-- Takes a Game and creates a string representation of that game state 
showGame :: Game -> String
showGame (board, cp) = unlines $ (colorToString cp) : (convertBoard board)
    
-- Converts a board to a list of Strings, with each color as it's string representation
-- Board = [[String]]
convertBoard :: Board -> [String]
convertBoard board = [if null col then "\n" else unlines (map (colorToString) col) | col <- board]
  
   
-- Converts a color to it's string representation
colorToString :: Color -> String
colorToString color =
    case color of
        Yellow -> "1"
        Red -> "2"


convertToBoard :: [String] -> Board 
convertToBoard = undefined

