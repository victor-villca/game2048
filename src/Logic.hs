module Logic where

import Data.Array
import Foreign.Marshal.Unsafe
import Game
import System.Random

-- Función para crear un nuevo tablero vacío
createEmptyBoard :: Int -> Board
createEmptyBoard a = array indexRange $ zip (range indexRange) (cycle [Empty])
  where
    indexRange = ((0, 0), (a - 1, a - 1))

getEmptyCells :: Board -> [(Int, Int)]
getEmptyCells board = filter (\coord -> board ! coord == Empty) (indices board)

randomNumber :: Int -> Int -> Int
randomNumber a b = unsafeLocalState (randomRIO (a, b))

getRandomCell :: [(Int, Int)] -> (Int, Int)
getRandomCell [] = (-1, -1)
getRandomCell list = list !! randomNumber 0 (length list - 1)

getRandomNumber :: Int -> Int
getRandomNumber a 
  | a == 3 = 4
  | otherwise = 2

generateRandomCell :: Int -> Int -> Board -> Board
generateRandomCell a b board = board // [(getRandomCell (getEmptyCells board), Ocuppied (getRandomNumber (randomNumber a b)))]

genBoard :: Int -> Board
genBoard x = generateRandomCell 0 9 (createEmptyBoard x)

initialBoard :: Int -> Board
initialBoard x = generateRandomCell 1 10 (genBoard x)

transformGame :: a -> Game -> Game
transformGame _ game = game
