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

getRandomNumber :: Int
getRandomNumber 
  | a == 1 = 4
  | otherwise = 2
  where
    a = randomNumber 0 9

generateRandomCell :: Board -> Board
generateRandomCell board = board // [(getRandomCell (getEmptyCells board), Ocuppied getRandomNumber)]

genBoard :: Int -> Board
genBoard x = generateRandomCell (createEmptyBoard x)

initialBoard :: Int -> Board
initialBoard x = generateRandomCell (genBoard x)

transformGame :: a -> Game -> Game
transformGame _ game = game
