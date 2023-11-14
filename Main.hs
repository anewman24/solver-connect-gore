module Main where
import Solver
import TestCases

import System.Environment
import System.IO

main :: IO ()
main =
    do args <- getArgs


--Computes the best move and prints it to standard output, also should return result of said game
putBestMove :: Game -> IO ()

--Writes a game state to a file
writeGame :: Game -> FilePath -> IO ()

--Loads a file and reads a game state from it
loadGame :: FilePath -> IO Game
loadGame path = 
    do contents <- (readFile path) -- gives whole file as a string
       let (g:gs) = lines contents -- creates a list where each newline is a string
       
readGame :: String -> Game

-- 
showGame :: Game -> String
showGame game = 
    let (board, color) = game
    in 

-- Converts a board to a list of Strings, with each color as it's string representation
convertBoard :: Board -> [String]
convertBoard board = map (colorToString) 

-- Converts a color to it's string representation
colorToString :: Color -> String
colorToString color =
    case color of
        Yellow -> "1"
        Red -> "2"


convertToBoard :: [String] -> Board 
