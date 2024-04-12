module Rendering where

import Graphics.Gloss
import Game
import Data.Array
import Utils

-- GRID DRAWING
boardGridColor :: Color
boardGridColor = makeColorI 0 0 0 255 


-- combines all the lines of the board into a single picture
-- where drawlines generate a pair of lines for each valui in the list
boardGrid :: Picture
boardGrid = pictures $ concatMap drawLines [0.0 .. fromIntegral n]
  where
    drawLines i = [ line [(i * cellWidth, 0.0), (i * cellWidth, fromIntegral screenHeight)]
                  , line [(0.0, i * cellHeight), (fromIntegral screenWidth, i * cellHeight)]]

-- CELL DRAWING

drawCell :: (Int, Int) -> Cell -> Picture
drawCell _ Empty = blank
drawCell (x, y) (Ocuppied value) = pictures [ coloredRectangle, translatedText ]
  where
    coloredRectangle = translate (fromIntegral x * cellWidth + cellWidth / 2) (fromIntegral y * cellHeight + cellHeight / 2) $ color red $ rectangleSolid cellWidth cellHeight
    translatedText = translate (fromIntegral x * cellWidth + cellWidth / 2 -20 ) (fromIntegral y * cellHeight + cellHeight / 2 -20) $ scale 0.5 0.5 $ boldText 1.4 $ color white $ text (show value)


-- Iteratates throught the board to draw each cell and combines it with the board grid 
-- as one single picture
-- BOARD DRAWING
boardAsRunningPicture :: Board -> Picture
boardAsRunningPicture board = pictures [ color boardGridColor boardGrid, cellsPictures ]
  where
    cellsPictures = pictures [ drawCell (x, y) cell | x <- [0..n-1], y <- [0..n-1], let cell = board ! (x, y) ]

gameAsPicture :: Game -> Picture
gameAsPicture game = translate (fromIntegral screenWidth * (-0.5)) (fromIntegral screenHeight * (-0.5)) frame
  where
    frame = boardAsRunningPicture $ gameBoard game
