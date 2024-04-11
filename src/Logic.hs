module Logic where

import Data.Array
import Game
import System.Random

-- devuelve las celdas vacias del tablero
getEmptyCells :: Board -> [(Int, Int)]
getEmptyCells board = [index | (index, state) <- assocs board, state == Empty]

-- Función para crear un nuevo tablero vacío
createEmptyBoard :: Int -> Board
createEmptyBoard n = array indexRange $ zip (range indexRange) (cycle [Empty])
    where indexRange = ((0, 0), (n - 1, n - 1))

-- Función para generar un número aleatorio entre 1 y 10
randomNumber :: IO Int
randomNumber = randomRIO (1, 10)

-- Función para generar un 2 o un 4 con una probabilidad del 90% para 2 y 10% para 4
generateNumber :: IO Int
generateNumber = do
    rand <- randomNumber
    if rand == 10
        then return 4
        else return 2

-- Función para colocar dos números aleatorios en el tablero
-- Tomar dos ubicaciones aleatorias diferentes del tablero
-- Generar dos números aleatorios
-- Colocar los números aleatorios en las ubicaciones del tablero
initializeBoard :: Board -> IO Board
initializeBoard board = do
    -------
    emptyCells <- pure $ getEmptyCells board
    let [index1, index2] = take 2 emptyCells
    -------
    number1 <- generateNumber
    number2 <- generateNumber
    -------
    let newBoard = board // [(index1, Ocuppied number1), (index2, Ocuppied number2)]
    return newBoard


-- este metodo retorna el tablero con 2 celdas generadas automaticamente 
-- le pasas el tamaño del tablero
-- si quieres un 4x4 le pasas 4
createAndPopulateBoard :: Int -> IO Board
createAndPopulateBoard size = do
    let emptyBoard = createEmptyBoard size 
    initializeBoard emptyBoard 