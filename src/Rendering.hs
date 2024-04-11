module Rendering where

import Graphics.Gloss

import Game
import Data.Array

boardGridColor = makeColorI 255 255 255 255 
tieColor = greyN 0.5

-- | Convierte el tablero en una imagen en funcionamiento.
boardAsRunningPicture :: Board   -- ^ El tablero del juego.
                      -> Picture -- ^ La imagen del tablero.
boardAsRunningPicture board = 
    pictures [ color boardGridColor $ boardGrid]


-- | Genera el diseño del tablero con líneas que forman las celdas.
boardGrid :: Picture
boardGrid = 
    pictures
    $ concatMap (\i -> [ line [(i * cellWidth, 0.0)
                              ,(i * cellWidth, fromIntegral screenHeight)]
                        ,line [(0.0,i * cellHeight)
                              ,(fromIntegral screenWidth, i * cellHeight)]])
    [0.0  .. fromIntegral n]

-- | Genera la imagen del juego
gameAsPicture :: Game -> Picture
gameAsPicture game = translate (fromIntegral screenWidth * (-0.5))
                               (fromIntegral screenHeight * (-0.5))
                               frame
    where frame  = case gameState game of
            Running -> boardAsRunningPicture (gameBoard game)
            --implementar despues
            GameOver -> boardAsRunningPicture (gameBoard game)
    