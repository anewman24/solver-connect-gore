module Main where
import Solver
import GameMechanics
--import TestCases
import System.Console.GetOpt
import System.Environment
import System.IO

data Flag = Help | Victor | Verbose | Interactive | Moves String | Depth String deriving (Show, Eq) 

options :: [OptDescr Flag]
options = [ Option ['h'] ["help"] (NoArg Help) "Print usage information and exit."
          , Option ['w'] ["winner"] (NoArg Victor) "Print the best move from an exhaustive search."
          , Option ['v'] ["verbose"] (NoArg Verbose) "Print the move and a description of how good it is: win, lose, tie, or a rating. "
          , Option ['i'] ["ineractive"] (NoArg Interactive) "Start a new game and play against the computer. "
          , Option ['m'] ["move"] (ReqArg Moves "<num>") "Makes the given move and prints resulting board. "
          , Option ['d'] ["depth"] (ReqArg Depth "<num>")
                  "Allows the user to specify a cut-off depth when searching for the winner instea dof using the default. "
          ]


-- reads a file name from standard input or the arguments, loads the game, and prints the best move
-- have -v flag print result of such a move
main :: IO ()
main = 
    do args <- getArgs
       let (flags, inputs, errors) = getOpt Permute options args
       if Help `elem` flags || not (null errors)
       then putStrLn $ usageInfo "Main [options] [filename] \nInteractive implementation of connect four. " options
       else 
           do let fname = if null inputs then "sampleGame.txt" else head inputs
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
loadGame path =
    do contents <- (readFile path) -- gives whole file as a string
       let results = readGame contents
       return results



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

