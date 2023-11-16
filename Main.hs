module Main where
import Solver
import TestCases

import System.Environment
import System.IO
import GHC.Base (undefined)

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

--Takes a string in a text format and return the corresponding game
readGame :: String -> Game
readGame str = undefined

-- 
showGame :: Game -> String
showGame game = 
    let (board, color) = game
        colorString = colorToString color
        lstColumns = unlines (convertBoard board)
    in colorString: "\n" ++ lstColumns

-- Converts a board to a list of Strings, with each color as it's string representation
-- Board = [[String]]
convertBoard :: Board -> [String]
convertBoard board = 
    let strBoard = [if null column then column else map (colorToString) column | column <- Board ]
        lstLines = [ (replicate (7- length col) "0") ++ col | col <- strBoard ]
    in [unwords line | line <- lstLines]


-- Converts a color to it's string representation
colorToString :: Color -> String
colorToString color =
    case color of
        Yellow -> "1"
        Red -> "2"

--Converts the string to a color
stringtoColor :: String -> Color
stringtoColor string = 
    case string of
        "1" -> Yellow
        "2" -> Red

convertToBoard :: [String] -> Board 
