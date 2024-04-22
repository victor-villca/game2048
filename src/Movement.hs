module Movement(performMove) where
import Data.Array
import Data.List
import Game
import Utils
import Random
import GameOver


-- Shifts all the non empty cells in a row to the left
-- Empty cells are moved to the right side of the row
shiftRow :: [Cell] -> [Cell]
shiftRow row = filtered ++ padding
  where
    filtered = filter (/= Empty) row
    padding = replicate (length row - length filtered) Empty

mergeCells :: [Cell] -> ([Cell], Int)
mergeCells [] = ([], 0)
mergeCells [x] = ([x], 0)
mergeCells (x : y : xs)
  | x == y && x /= Empty = (Ocuppied value : mergedTail, value + score)
  | otherwise = (x : otherMerge, otherScore)
  where
    (mergedTail, score) = mergeCells xs
    value = getValue x + getValue y
    (otherMerge, otherScore) = mergeCells (y : xs)

mergeBoard :: [[Cell]] -> ([[Cell]], Int)
mergeBoard [] = ([], 0)
mergeBoard (x : xs) = ((merged ++ padding) : mergedTail, score + scoreTail)
  where
    (merged, score) = mergeCells x
    padding = replicate (length x - length merged) Empty
    (mergedTail, scoreTail) = mergeBoard xs

merge :: [[Cell]] -> Direction -> ([[Cell]], Int)
merge [] _ = ([], 0)
merge cell d = (move, score)
  where
    (newCells, score) = mergeBoard cell
    move = case d of
      TopMov -> transpose newCells
      DownMov -> transpose $ map reverse newCells
      LeftMov -> newCells
      RightMov -> map reverse newCells


getValue :: Cell -> Int
getValue (Ocuppied value) = value
getValue _ = 0

-- Performs a move in the game in a given direction
-- The game board is updated based on it
performMove :: Direction -> Game -> Game
performMove direction game = g
  where
    board = gameBoard game
    (movedBoard, extraScore) = case direction of
      TopMov -> moveBoard TopMov board
      DownMov -> moveBoard DownMov board
      LeftMov -> moveBoard LeftMov board
      RightMov -> moveBoard RightMov board
    newBoard = generateRandomCell 0 9 movedBoard
    newScore = gameScore game + extraScore
    newState = verifyGameOver newBoard
    g = calculateBestScore (game {gameBoard = newBoard, gameScore = newScore, gameState = newState})

-- Moves all cells in the board towards the specified direction
-- Cells are shifted row by row or column by column, depending on the direction
-- And a new boardis returned with the cellls shifted in the given directon
moveBoard :: Direction -> Board -> (Board, Int)
moveBoard direction board = (accumArray updateCell Empty ((0, 0), (n - 1, n - 1)) newCells, score)
  where
    rows = [[board ! (i, j) | j <- [0 .. n - 1]] | i <- [0 .. n - 1]]
    shiftedRows = case direction of
      TopMov -> map shiftRow $ transpose rows
      DownMov -> map (shiftRow . reverse) $ transpose rows
      LeftMov -> map shiftRow rows
      RightMov -> map (shiftRow . reverse) rows
    (mergedCells, score) = merge shiftedRows direction
    newCells = concat [zip [(i, j) | j <- [0 .. n - 1]] row | (i, row) <- zip [0 ..] mergedCells]
    updateCell cell Empty = cell
    updateCell _ (Ocuppied x) = Ocuppied x

calculateBestScore :: Game -> Game
calculateBestScore g
  | btS < score = g {bestScore = score}
  | otherwise = g
  where
    btS = bestScore g
    score = gameScore g
