module Rendering where

import Graphics.Gloss
import Game
import Data.Array 
import Utils

-- Asigna un color a cada valor de celda
cellColor :: Int -> Color
cellColor value = case value of
    2    -> makeColorI 238 228 218 255   -- beige
    4    -> makeColorI 237 224 200 255   -- light orange
    8    -> makeColorI 242 177 121 255   -- orange
    16   -> makeColorI 245 149 99 255    -- light red
    32   -> makeColorI 246 124 95 255    -- red
    64   -> makeColorI 246 94 59 255     -- strong red
    128  -> makeColorI 237 207 114 255   -- light yellow
    256  -> makeColorI 237 204 97 255    -- yellow
    512  -> makeColorI 237 200 80 255    -- strong yellow
    1024 -> makeColorI 237 197 63 255    -- light green
    2048 -> makeColorI 237 194 46 255    -- green
    _    -> makeColorI 205 193 180 255   -- default color (para cualquier otro valor)

-- Draws a cell with a colour based on its value
drawCell :: (Int, Int) -> Cell -> Picture
drawCell _ Empty = blank
drawCell (y, x) (Ocuppied value) = pictures [ coloredRectangle, translatedText ]
  where
    cellBackgroundColor = cellColor value
    coloredRectangle = translate (fromIntegral x * cellWidth + cellWidth / 2) (fromIntegral (n - y) * cellHeight - cellHeight / 2) $ color cellBackgroundColor $ rectangleSolid cellWidth cellHeight
    translatedText = translate (fromIntegral x * cellWidth + cellWidth / 2 -20 ) (fromIntegral (n - y) * cellHeight - cellHeight / 2 -20) $ scale 0.5 0.5 $ boldText 1.4 $ color black $ text (show value)

-- GRID DRAWING
boardGridColor :: Color
boardGridColor = makeColorI 0 0 0 255 

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

gameAsPicture :: Game -> Picture
gameAsPicture game = translate (fromIntegral screenWidth * (-0.5)) (fromIntegral screenHeight * (-0.5)) frame
  where
    frame = boardAsRunningPicture $ gameBoard game
