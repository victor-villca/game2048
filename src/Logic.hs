module Logic where

import Data.Array
import Foreign.Marshal.Unsafe
import Game
import Graphics.Gloss.Interface.Pure.Game
import System.Random
import Data.List (transpose)

-- Función para crear un nuevo tablero vacío
createEmptyBoard :: Int -> Board
createEmptyBoard a = array indexRange $ zip (range indexRange) (cycle [Empty])
  where
    indexRange = ((0, 0), (a - 1, a - 1))

getEmptyCells :: Board -> [(Int, Int)]
getEmptyCells board = filter (\coord -> board ! coord == Empty) (indices board)

randomNumber :: Int -> Int -> Int
randomNumber a b = unsafeLocalState (randomRIO (a, b))

randomNumber1 :: Int -> Int -> Int
randomNumber1 a b = unsafeLocalState (randomRIO (a, b))

getRandomCell :: [(Int, Int)] -> (Int, Int)
getRandomCell [] = (-1, -1)
getRandomCell list = list !! randomNumber 0 (length list - 1)

getRandomNumber :: Int
getRandomNumber 
  | a == 1 = 4
  | otherwise = 2
  where
    a = randomNumber 0 9

getRandomNumber1 :: Int
getRandomNumber1 
  | a == 2 = 4
  | otherwise = 2
  where
    a = randomNumber1 1 10

generateRandomCell :: Board -> Board
generateRandomCell board 
  | getEmptyCells board /= [] = board // [(getRandomCell (getEmptyCells board), Ocuppied getRandomNumber)]

generateRandomCell1 :: Board -> Board
generateRandomCell1 board 
  | getEmptyCells board /= [] = board // [(getRandomCell (getEmptyCells board), Ocuppied getRandomNumber1)]

genBoard :: Int -> Board
genBoard x = generateRandomCell (createEmptyBoard x)

initialBoard :: Int -> Board
initialBoard n = generateRandomCell1 (genBoard n)

-- Shifts all the non empty cells in a row to the left
-- Empty cells are moved to the right side of the row
shiftRow :: [Cell] -> [Cell]
shiftRow row = filtered ++ padding
  where
    filtered = filter (/= Empty) row
    padding = replicate (length row - length filtered) Empty

-- Performs a move in the game in a given direction
-- The game board is updated based on it
performMove :: Direction -> Game -> Game
performMove direction game = game { gameBoard = newBoard }
  where
    board = gameBoard game
    movedBoard = case direction of
      TopMov -> moveBoard  TopMov board
      DownMov -> moveBoard  DownMov board
      LeftMov -> moveBoard LeftMov board
      RightMov -> moveBoard  RightMov board
    newBoard = generateRandomCell movedBoard

-- Moves all cells in the board towards the specified direction
-- Cells are shifted row by row or column by column, depending on the direction 
-- And a new boardis returned with the cellls shifted in the given directon
moveBoard :: Direction -> Board -> Board
moveBoard direction board = array ((0, 0), (n - 1, n - 1)) newCells
  where
    rows = [[board ! (i, j) | j <- [0..n-1]] | i <- [0..n-1]] --List of rows where each row is  a list of the cells of the board
    newRows = case direction of
      TopMov -> transpose $ map shiftRow $ transpose rows
      DownMov -> transpose $ map (reverse . shiftRow . reverse) $ transpose rows
      LeftMov -> map shiftRow rows
      RightMov -> map (reverse . shiftRow . reverse) rows
    newCells = [((i, j), newRows !! i !! j) | i <- [0..n-1], j <- [0..n-1]] --We use !! cause we are indexing from a list, and we do it twice to ge the row and then the column

transformGame :: Event -> Game -> Game
transformGame (EventKey (SpecialKey KeyUp) Down _ _) game = performMove TopMov game
transformGame (EventKey (SpecialKey KeyDown) Down _ _) game = performMove DownMov game
transformGame (EventKey (SpecialKey KeyLeft) Down _ _) game = performMove LeftMov game
transformGame (EventKey (SpecialKey KeyRight) Down _ _) game = performMove RightMov game
transformGame _ game = game