module Random(genBoard, generateRandomCell, generateTwoRandomCells) where
import Data.Array
import Foreign.Marshal.Unsafe
import Game
import System.Random
import Utils

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
generateRandomCell a b board
  | getEmptyCells board /= [] = board // [(getRandomCell (getEmptyCells board), Ocuppied (getRandomNumber (randomNumber a b)))]
  | otherwise = board

genBoard :: Int -> Board
genBoard x = generateRandomCell 0 9 (createEmptyBoard x)

-- This function returns a new Board with two random tiles and a new random generator
generateTwoRandomCells :: StdGen -> Board -> (Board, StdGen)
generateTwoRandomCells gen board =  (newBoard, newGen)
  where
    (boardAux, genAux) =  generateRandomCellStdGen gen board
    (newBoard, newGen) =  generateRandomCellStdGen genAux boardAux


-- This function returns a newBoard with a new random cell in an empty cell position and a new random generator
generateRandomCellStdGen :: StdGen -> Board -> (Board, StdGen)
generateRandomCellStdGen gen board = (board // [(randCellPos, Ocuppied randNumber)], newGen)
  where
    emptyCells = getEmptyCells board
    (randCellPos, gen1) = randomElement gen emptyCells
    (randVal, newGen) = randomR (0, 9) gen1
    randNumber = if (randVal :: Int) == 0 then getNextTile else getInitialTile


-- This function returns you a random element from a given list and a new random generator
randomElement :: StdGen -> [a] -> (a, StdGen)
randomElement gen list = (list !! index', newGen)
  where
    (index', newGen) = randomR (0, length list - 1) gen
