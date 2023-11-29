module TestInputs where
import GameMechanics

correctColumn = [Red,Yellow,Red,Red]
tooBigCol = [Red,Yellow,Red,Red,Yellow,Red,Yellow]


--if run findWinner will get Win Red
redWin1 = ([[],[Yellow,Red,Red],[Yellow,Red,Red,Yellow],[Red,Yellow],[Yellow,Red,Red,Yellow],[Yellow,Red],[]], Yellow)

--If run findWinner will get Win Yellow
yellowWin1 = ([[Yellow,Red],[Yellow,Red],[Yellow,Yellow],[Yellow,Red],[Red,Red],[],[]], Red)


-- if run whoWillWin on this, should get Red
simpleWhoWillWinRed = ([[Red,Red,Red],[Yellow,Yellow,Yellow],[],[],[],[]], Red)

-- if run whoWillWin on this, sould get Yellow
simpleWhoWillWinYellow = ([[Red,Red,Red],[Yellow,Yellow,Yellow],[],[],[],[]], Yellow)


--has too many values in a column
invalidGame1 = ([[Red],[Yellow],tooBigCol,[],[],[],[]] Red)

-- has too many columns
invalidGame2 = ([[Red],[Yellow],[Yellow,Red],[Red],[],[],[],[Red]] Red)
