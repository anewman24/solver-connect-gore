--will put all test inputs from Game Mechanics into here
module TestInputs where
import GameMechanics

correctColumn = [Red,Yellow,Red,Red]
tooBigCol = [Red,Yellow,Red,Red,Yellow,Red,Yellow]

--if run findWinner will get Win Red
redWin1 = ([[],[Yellow,Red,Red],[Yellow,Red,Red,Yellow],[Red,Yellow],[Yellow,Red,Red,Yellow],[Yellow,Red],[]], Yellow)

--If run findWinner will get Win Yellow
yellowWin1 = ([[Yellow,Red],[Yellow,Red],[Yellow,Yellow],[Yellow,Red],[Red,Red],[],[]], Red)




