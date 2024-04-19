module Game where
import System.Random (StdGen)


import Data.Array

data State = Running | GameOver deriving (Eq)

data Cell = Empty | Ocuppied Int deriving (Eq,Show)

type Board = Array (Int, Int) Cell

data Direction = TopMov | DownMov | LeftMov | RightMov deriving(Eq)
data Game = Game {gameBoard :: Board,
                  gameState :: State,
                  gameScore :: Int,
                  gameStdGen :: StdGen
                  } deriving (Eq)

n :: Int 
n = 4

screenWidth :: Int
screenWidth = 640

screenHeight :: Int 
screenHeight = 480

cellWidth :: Float
cellWidth = fromIntegral screenWidth / fromIntegral n

cellHeight :: Float
cellHeight = fromIntegral screenHeight / fromIntegral n 

getInitialTile :: Int
getInitialTile = 2

getNextTile :: Int
getNextTile = 4