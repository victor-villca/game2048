module GameOver(verifyGameOver) where
import Data.Array
import Game
import Utils

verifyGameOver :: Board -> State
verifyGameOver board
  | emptyCells == [] && noMergePossible = GameOver
  | otherwise = Running
  where
    emptyCells = getEmptyCells board
    noMergePossible = not (any id (map (\index -> verifyDirections index board) (indices board)))

verifyDirections :: (Int, Int) -> Board -> Bool
verifyDirections index board = 
  verifyUp index board || verifyDown index board || verifyLeft index board || verifyRight index board

verifyUp :: (Int, Int) -> Board -> Bool
verifyUp (x, y) board = x > 0 && board ! (x, y) == board ! (x-1, y)

verifyDown :: (Int, Int) -> Board -> Bool
verifyDown (x, y) board = x < n-1 && board ! (x, y) == board ! (x+1, y)

verifyLeft :: (Int, Int) -> Board -> Bool
verifyLeft (x, y) board = y > 0 && board ! (x, y) == board ! (x, y-1)

verifyRight :: (Int, Int) -> Board -> Bool
verifyRight (x, y) board = y < n-1 && board ! (x, y) == board ! (x, y+1)