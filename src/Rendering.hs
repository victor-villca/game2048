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
drawCell (y, x) Empty = pictures [coloredEmpty]
  where
    coloredEmpty = translate (fromIntegral x * cellWidth + cellWidth / 2) (fromIntegral (n - y) * cellHeight - cellHeight / 2) $ color (cellColor 0) $ rectangleSolid (cellWidth - 10) (cellHeight - 10)
drawCell (y, x) (Ocuppied value) = pictures [coloredRectangle, translatedText]
  where
    cellBackgroundColor = cellColor value
    coloredRectangle = translate (fromIntegral x * cellWidth + cellWidth / 2) (fromIntegral (n - y) * cellHeight - cellHeight / 2) $ color cellBackgroundColor $ rectangleSolid (cellWidth - 10) (cellHeight - 10)
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
boardGrid = translate (fromIntegral screenWidth / 2) (fromIntegral screenHeight / 2) $ color boardGridColor $ rectangleSolid (fromIntegral screenWidth + 10) (fromIntegral screenHeight + 10)

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
    translatedText = translate (0) (fromIntegral screenHeight +28) $ scale 0.5 0.5 $ boldText 1.4 $ color black $ text (stringGameOver)

boardAsGameOverPicture :: Board -> Picture
boardAsGameOverPicture board = pictures [ color boardGridColor boardGrid, cellsPictures, gameOverMessage]
  where
    cellsPictures = pictures [ drawCell (x, y) cell | x <- [0..n-1], y <- [0..n-1], let cell = board ! (x, y) ]

gameAsPicture :: Game -> Picture
gameAsPicture game = pictures [ translate (fromIntegral screenWidth * (-0.5)) (fromIntegral screenHeight * (-0.5)) frame
                              , scoreText
                              , winMessage
                              , bestScoreText
                              , instructionText
                              , gameTitle
                              , madeByText
                              , name
                              ]
  where
    frameRunning = boardAsRunningPicture $ gameBoard game
    frameOver = boardAsGameOverPicture $ gameBoard game
    frame = case gameState game of
      GameOver -> frameOver
      Running -> frameRunning
    scoreText = translate (fromIntegral screenWidth * (0.2)) (fromIntegral screenHeight * (0.6)) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text ("Score: " ++ show (gameScore game))
    winCellValue = winningValue game
    winMessage = if any (\(_, cell) -> case cell of Ocuppied value -> value == winCellValue; _ -> False) (assocs (gameBoard game))
                    then translatedWinMessage
                    else blank
    translatedWinMessage = translate (-fromIntegral screenWidth * 0.5) (fromIntegral screenHeight * 0.55) $ scale 0.5 0.5 $ boldText 1.4 $ color black $ text ("You Win!")

    bestScoreText = translate (fromIntegral screenWidth * (0.2)) (fromIntegral screenHeight * (0.7)) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text ("Best Score: " ++ show (bestScore game))

    instructionText = translate (-fromIntegral screenWidth * 0.5) (-fromIntegral screenHeight * 0.61) $ scale 0.2 0.2 $ color black $ pictures [
      translate 0 80 $ boldText 1.4 $ text "You can move the pieces with the arrow keys.",
      translate 0 (-80) $ boldText 1.4 $ text "The sum of two cells will be the assigned score.",
      translate 0 (-240) $ boldText 1.4 $ text "To restart the game use the R key.",
      translate 0 (-400) $ boldText 1.4 $ text "The highest score remains while the app runs.",
      translate 0 (-560) $ boldText 1.4 $ text "You can use the Esc key to exit the application.",
      translate 0 (-720) $ boldText 1.4 $ text "Press C to continue the game after winning."
      ]

    gameTitle = translate (fromIntegral screenWidth * (-0.7) - 100) (fromIntegral screenHeight * 0.8 - 50) $ scale 1 1 $ boldText 1.4 $ color black $ text "2048"
    madeByText = translate (fromIntegral screenWidth * (-0.7) - 100) (fromIntegral screenHeight * 0.8 - 100) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text "Made by:"
    name = translate (fromIntegral screenWidth * (-0.7) - 100) (fromIntegral screenHeight * 0.8 - 150) $ scale 0.3 0.3 $ boldText 1.4 $ color black $ text "[A elegir]"

--Method to see all the board with all the cells of the game
drawFullGame :: Picture
drawFullGame = gameAsPicture (Game createFullBoard Running 0 0 winning (mkStdGen 0))
