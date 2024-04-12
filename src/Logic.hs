module Logic where

import Data.Array
import Game
import System.Random

-- Función para crear un nuevo tablero vacío
createEmptyBoard :: Int -> Board
createEmptyBoard n = array indexRange $ zip (range indexRange) (cycle [Empty])
    where indexRange = ((0, 0), (n - 1, n - 1))

getEmptyCells :: Board -> [(Int, Int)]
getEmptyCells board = filter (\coord -> board ! coord == Empty) (indices board)

randomNumber :: Int -> Int -> IO Int
randomNumber min max = randomRIO (min, max)

getRandomCell :: [(Int, Int)] -> IO (Int, Int)
getRandomCell [] = return (-1, -1)
getRandomCell list = do
    randomIndex <- randomNumber 0 (length list - 1)
    return (list !! randomIndex)

generateNumber :: IO Int
generateNumber = do
    rand <- randomNumber 1 10
    if rand == 10
        then return 4
        else return 2

generateRandomCell :: Board -> IO Board
generateRandomCell board = do
    number <- generateNumber
    cell <- getRandomCell (getEmptyCells board)
    return (board // [(cell, Ocuppied number)])

transformGame _ game = game