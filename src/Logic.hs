module Logic where

import Data.Array
import Game
import System.Random

-- Función para crear un nuevo tablero vacío
createEmptyBoard :: Int -> Board
createEmptyBoard n = array indexRange $ zip (range indexRange) (cycle [Empty])
  where
    indexRange = ((0, 0), (n - 1, n - 1))

initialBoard :: Int -> Board
initialBoard n = createEmptyBoard n // [((3, 3), (Ocuppied 1)), ((0, 0), (Ocuppied 2)) ]

transformGame :: a -> Game -> Game
transformGame _ game = game
