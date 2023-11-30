module Main where
import GameMechanics
import TestCases

import System.Environment
import System.IO
import GHC.Base (undefined)

main :: IO ()
main =
    do args <- getArgs
       putStr "Empty string"


--Computes the best move and prints it to standard output, also should return result of said game
putBestMove :: Game -> IO ()
putBestMove (board,color) = undefined

--Writes a game state to a file
writeGame :: Game -> FilePath -> IO ()
writeGame (board,color) = undefined

--Loads a file and reads a game state from it
loadGame :: FilePath -> IO Game
loadGame path = undefined
    --do contents <- (readFile path) -- gives whole file as a string
       --let (g:gs) = lines contents -- creates a list where each newline is a string

--Takes a string in a text format and return the corresponding game
readGame :: String -> Game
readGame str = 
    case words str of
        (cp:columns) ->
            (convertToBoard columns, stringtoColor (stringToChar cp))
        

        


-- 
showGame :: Game -> String
showGame (board, cp) = unlines $ (colorToString cp) : (convertBoard board)

-- Converts a board to a list of Strings, with each color as it's string representation
-- Board = [[String]]
convertBoard :: Board -> [String]
convertBoard board = [if null col then "\n" else unwords (map (colorToString) col) | col <- board]


-- Converts a color to it's string representation
colorToString :: Color -> String
colorToString color =
    case color of
        Yellow -> "1"
        Red -> "2"

--String to char
stringToChar :: String -> Char
stringToChar str = 
    case str of
        "1" -> '1'
        "2" -> '2'

--Converts the char to a color
stringtoColor :: Char -> Color
stringtoColor char = 
    case char of
        '1' -> Yellow
        '2' -> Red

--Converts a list of String to a board where each string represent a color or empty
convertToBoard :: [String] -> Board 
convertToBoard lstString = [if column == "" then [] else  map stringtoColor column | column <- lstString]
 
