module Rendering(gameAsPicture, drawFullGame) where
import Graphics.Gloss
import Data.Array 
import Game
import Utils
import System.Random (mkStdGen)
import Game (createFullBoard, Game(..))


boardGridColor :: Color
boardGridColor = makeColorI 36 53 73 255 

-- Draws a cell with a colour based on its value
drawCell :: (Int, Int) -> Cell -> Picture
drawCell _ Empty = blank
drawCell (y, x) (Ocuppied value) = pictures [coloredRectangle, translatedText]
  where
    cellBackgroundColor = cellColor value
    coloredRectangle = translate (fromIntegral x * cellWidth + cellWidth / 2) (fromIntegral (n - y) * cellHeight - cellHeight / 2) $ color cellBackgroundColor $ rectangleSolid cellWidth cellHeight
    translatedText = translateText (fromIntegral x * cellWidth + cellWidth / 2) (fromIntegral (n - y) * cellHeight - cellHeight / 2) value

-- Auxiliar function to adjust the position of the text depends of the value
translateText :: Float -> Float -> Int -> Picture
translateText xPos yPos value
  | value `elem` [1, 2, 4, 8] = translate (xPos - 10) (yPos - 15) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text (show value)
  | value `elem` [16, 32, 64] = translate (xPos - 20) (yPos - 15) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text (show value)
  | value `elem` [128, 256, 512] = translate (xPos - 30) (yPos - 15) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text (show value)
  | otherwise = translate (xPos - 40) (yPos - 15) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text (show value)

-- Combines all the lines on the board into a single image
-- where drawLines generates a pair of lines for each value in the list
boardGrid :: Picture
boardGrid = pictures $ concatMap drawLines [0.0 .. fromIntegral n]
  where
    drawLines i = [ line [(i * cellWidth, 0.0), (i * cellWidth, fromIntegral screenHeight)]
                  , line [(0.0, i * cellHeight), (fromIntegral screenWidth, i *  cellHeight)]]

-- rotate around the board to draw each cell and combine them with the grid on the board
-- as a single image
-- BOARD DRAWING
boardAsRunningPicture :: Board -> Picture
boardAsRunningPicture board = pictures [ color boardGridColor boardGrid, cellsPictures ]
  where
    cellsPictures = pictures [ drawCell (x, y) cell | x <- [0..n-1], y <- [0..n-1], let cell = board ! (x, y) ]

gameOverMessage :: Picture
gameOverMessage = pictures [translatedText]
  where
    translatedText = translate (0) (fromIntegral screenHeight +60) $ scale 0.5 0.5 $ boldText 1.4 $ color black $ text (stringGameOver)

boardAsGameOverPicture :: Board -> Picture
boardAsGameOverPicture board = pictures [ color boardGridColor boardGrid, cellsPictures, gameOverMessage]
  where
    cellsPictures = pictures [ drawCell (x, y) cell | x <- [0..n-1], y <- [0..n-1], let cell = board ! (x, y) ]

gameAsPicture :: Game -> Picture
gameAsPicture game = pictures [ translate (fromIntegral screenWidth * (-0.5)) (fromIntegral screenHeight * (-0.5)) frame
                              , scoreText
                              , winMessage
                              , bestScoreText
                              ]
  where
    frameRunning = boardAsRunningPicture $ gameBoard game
    frameOver = boardAsGameOverPicture $ gameBoard game
    frame = case gameState game of
      GameOver -> frameOver
      Running -> frameRunning
    scoreText = translate (fromIntegral screenWidth * (0.2)) (fromIntegral screenHeight * (0.6)) $ scale 0.3 0.3 $ color black $ text ("Score: " ++ show (gameScore game))
    winMessage = if any (\(_, cell) -> case cell of Ocuppied value -> value == winCellValue; _ -> False) (assocs (gameBoard game))
                    then translatedWinMessage
                    else blank
    translatedWinMessage = translate (-fromIntegral screenWidth * 0.5) (fromIntegral screenHeight * 0.6) $ scale 0.5 0.5 $ boldText 1.4 $ color black $ text ("You Win!")

    bestScoreText = translate (fromIntegral screenWidth * (0.2)) (fromIntegral screenHeight * (0.7)) $ scale 0.3 0.3 $ color black $ text ("Best: " ++ show (bestScore game))

--Method to see all the board with all the cells of the game
drawFullGame :: Picture
drawFullGame = gameAsPicture (Game createFullBoard Running 0 0 (mkStdGen 0))
