module Main where
import Solver
import GameMechanics
--import TestCases
import System.Environment
import System.IO
import GHC.Base (undefined)

-- reads a file name from standard input or the arguments, loads the game, and prints the best move
-- have -v flag print result of such a move
main :: IO ()
main = 
    do args <- getArgs
       let fname = head args
       game <- loadGame fname
       putBestMove game


--Computes the best move and prints it to standard output, also should return result of said game
putBestMove :: Game -> IO ()
putBestMove game = putStr $ bestMove game

--Writes a game state to a file
writeGame :: Game -> FilePath -> IO ()
writeGame game path = writeFile path (showGame game)
       
--Loads a file and reads a game state from it
loadGame :: FilePath -> IO Game
loadGame path = undefined
    do contents <- (readFile path) -- gives whole file as a string
       let results = readGame contents
       return results


--Takes a string in a text format and returns the corresponding game
readGame :: String -> Game
readGame str = 
    case lines str of
        (cp:columns) ->
            (convertToBoard columns, stringToColor cp) 


-- Takes a game and converts it to the corresponding string in text format
showGame :: Game -> String
showGame (board, cp) = unlines $ (colorToString cp) : (convertBoard board)

-- Converts a board to a list of strings, with each color as it's string representation
convertBoard :: Board -> [String]
convertBoard board = [unwords (map (colorToString) col) | col <- board]


-- Converts a color to it's string representation
colorToString :: Color -> String
colorToString color =
    case color of
        Yellow -> "1"
        Red -> "2"

--Converts a string to it's corresponding color
stringToColor :: String -> Color
stringToColor str = 
    case str of
        "1" -> Yellow
        "2" -> Red

--Converts a list of String to a board where each string represent a color or empty column
convertToBoard :: [String] -> Board 
convertToBoard lstString = 
    [map stringToColor (words column) | column <- lstString]
 
