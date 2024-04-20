module Logic(transformGame, initialBoard) where
import Game
import Graphics.Gloss.Interface.Pure.Game
import Random
import Utils
import Movement


initialBoard :: Int -> Board
initialBoard x = generateRandomCell 1 10 (genBoard x)

-- This function restarts the game board, score and random generator
reinitializeGame :: Game -> Game
reinitializeGame game = game { gameBoard = newBoard, gameScore =0, gameStdGen = newStdGen', gameState = Running }
  where
    (newBoard, newStdGen') = generateTwoRandomCells (gameStdGen game) (createEmptyBoard n)

transformGame :: Event -> Game -> Game
transformGame (EventKey (SpecialKey KeyUp) Up _ _) game = performMove TopMov game
transformGame (EventKey (SpecialKey KeyDown) Up _ _) game = performMove DownMov game
transformGame (EventKey (SpecialKey KeyLeft) Up _ _) game = performMove LeftMov game
transformGame (EventKey (SpecialKey KeyRight) Up _ _) game = performMove RightMov game
transformGame (EventKey (Char 'r') Up _ _) game = reinitializeGame game
transformGame _ game = game