module Game where

import Data.Array

data State = Running | GameOver deriving (Eq)

data Cell = Empty | Ocuppied Int deriving (Eq,Show)

type Board = Array (Int, Int) Cell 

data Game = Game {gameBoard :: Board,
                  gameState :: State  
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