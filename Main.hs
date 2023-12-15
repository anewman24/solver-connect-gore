module Main where
import Solver
import GameMechanics
import System.Console.GetOpt
import System.Environment
import System.IO

data Flag = Help | WinnerFlag | Verbose | Interactive | MoveFlag String | Depth String deriving (Show, Eq) 

options :: [OptDescr Flag]
options = [ Option ['h'] ["help"] (NoArg Help) "Print usage information and exit."
          , Option ['w'] ["winner"] (NoArg WinnerFlag) "Print the best move from an exhaustive search."
          , Option ['v'] ["verbose"] (NoArg Verbose) "Print the move and a description of how good it is: win, lose, tie, or a rating. "
          , Option ['i'] ["ineractive"] (NoArg Interactive) "Start a new game and play against the computer. "
          , Option ['m'] ["move"] (ReqArg MoveFlag "<num>") "Makes the given move and prints resulting board. "
          , Option ['d'] ["depth"] (ReqArg Depth "<num>")
                  "Allows the user to specify a cut-off depth when searching for the winner instea dof using the default of 5. "
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
           do 
            let fname = if null inputs then "newGame.txt" else head inputs
            game <- loadGame fname
            dispatch flags game



-- takes a list of flags and the given game and does all the work with concern to         
dispatch :: [Flag] -> Game -> IO()
dispatch flags game 
    | WinnerFlag `elem` flags   = putBestMove game
    | Interactive `elem` flags  = undefined --interactivePlay 
    | (getMove flags) /= 0      = putMove game flags
    | otherwise                 = putGoodMove game flags



checkVerbose :: [Flag] -> Bool
checkVerbose [] = False
checkVerbose (Verbose:flags) = True
checkVerbose (f:flags) = checkVerbose flags


-- Checks if a move is present and if it is returns that move, else return Nothing 
getMove :: [Flag] -> Int --should I return this to a maybe?
getMove [] = 0
getMove (MoveFlag x:flags) = (read x) - 1
getMove (f:flags) = getMove flags


-- Given a list of flags will check if a specific depth is given or will default to 5
getDepth :: [Flag] -> Int
getDepth [] = 5
getDepth (Depth x:flags) = read x
getDepth (f:flags) = getDepth flags

-- Will create a new game to play against the computer --> start w/ player's move, update board
-- call whoMightWin --> update board w/ that move ask player for move 
--interactivePlay = undefined


--computerPlay :: Game -> [Flags] -> Game
--computerPlay game flags = 
    

--When given a move will make that move and print resulting board 
putMove :: Game -> [Flag] -> IO() 
putMove game flags = 
    if checkVerbose flags
    then case updateGame game (getMove flags) of
            Nothing -> putStrLn "Move given is invalid or no more moves can be made"
            Just game -> putStrLn $ showGame game
    else case updateGame game (getMove flags) of
            Nothing -> putStrLn "Move given is invalid or no more moves can be made"
            Just game -> putStrLn $ showBoard game

--Computes the best move and prints it to standard output, also should return result of said game
putBestMove :: Game -> IO ()
putBestMove game = 
    case bestMove game of 
        Nothing -> putStrLn "Cannot find a best move for a game that has already been won."
        Just move -> putStrLn (show move)

-- for normal running of program will print out a good move for the game, if verbose tag is present
-- will print result of that move
putGoodMove :: Game -> [Flag] -> IO()
putGoodMove game flags = 
    let (rating,move) = whoMightWin game (getDepth flags)
    in if checkVerbose flags
       then let resp = updateGame game move
            in case resp of
                Just game -> putStrLn $ (show move ++ "\n" ++ showGame game)
                Nothing -> putStrLn "An error has occurred, the move is not valid"
       else putStrLn $ show move

--Writes a game state to a file
writeGame :: Game -> FilePath -> IO ()
writeGame game path = writeFile path (showGame game)
       
--Loads a file and reads a game state from it
loadGame :: FilePath -> IO Game
loadGame path =
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

