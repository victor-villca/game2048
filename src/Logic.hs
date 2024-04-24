module Logic(transformGame, initialBoard) where
import Game
import Graphics.Gloss.Interface.Pure.Game
import Random
import Utils
import Movement
import Data.Array (elems)



initialBoard :: Int -> Board
initialBoard x = generateRandomCell 1 10 (genBoard x)

-- This function restarts the game board, score and random generator
reinitializeGame :: Game -> Game
reinitializeGame game = game { gameBoard = newBoard, gameScore =0, winningValue = winning, gameStdGen = newStdGen', gameState = Running }
  where
    (newBoard, newStdGen') = generateTwoRandomCells (gameStdGen game) (createEmptyBoard n)

isWinning :: Game -> Bool
isWinning game = any (\cell -> case cell of Ocuppied value -> value == winCellValue; _ -> False) (elems (gameBoard game))
  where
    winCellValue = winningValue game

continueGame :: Game -> Game
continueGame game = game {winningValue = -1};

transformGame :: Event -> Game -> Game
transformGame (EventKey (SpecialKey KeyUp) Up _ _) game
  | not (isWinning game) = performMove TopMov game
  | otherwise = game
transformGame (EventKey (SpecialKey KeyDown) Up _ _) game
  | not (isWinning game) = performMove DownMov game
  | otherwise = game
transformGame (EventKey (SpecialKey KeyLeft) Up _ _) game
  | not (isWinning game) = performMove LeftMov game
  | otherwise = game
transformGame (EventKey (SpecialKey KeyRight) Up _ _) game
  | not (isWinning game) = performMove RightMov game
  | otherwise = game
transformGame (EventKey (Char 'r') Down _ _) game = reinitializeGame game
transformGame (EventKey (Char 'c') Down _ _) game
  | not (isWinning game) = game
  | otherwise = continueGame game
transformGame _ game = game