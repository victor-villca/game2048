module Utils (
    boldText,
    numberToPicture,
    textToPicture,
    cellColor,
    createEmptyBoard,
    getEmptyCells
) where
import Graphics.Gloss
import Data.Array
import Game

-- Creates multiple lines to make it look bold
boldText :: Float -> Picture -> Picture
boldText offset textPic = pictures
    [ textPic
    , translate offset offset textPic
    , translate (-offset) offset textPic
    , translate offset (-offset) textPic
    , translate (-offset) (-offset) textPic
    ]

-- Takes and int and returns a bold picture of it
numberToPicture :: Int -> Picture
numberToPicture n = translate (-20) (-20) . scale 0.5 0.5 . boldText 1 . text $ show n


-- Converts text to picture
textToPicture :: String -> Picture
textToPicture s = text $ s


-- Asigna un color a cada valor de celda
cellColor :: Int -> Color
cellColor value = case value of
    2    -> makeColorI 134 228 249 255
    4    -> makeColorI 81 195 211 255
    8    -> makeColorI 23 147 187 255   
    16   -> makeColorI 24 113 190 255    
    32   -> makeColorI 98 111 196 255    
    64   -> makeColorI 204 114 190 255     
    128  -> makeColorI 255 137 162 255   
    256  -> makeColorI 250 182 152 255   
    512  -> makeColorI 239 133 112 255    
    1024 -> makeColorI 254 117 75 255    
    2048 -> makeColorI 245 98 98 255    
    _    -> makeColorI 206 221 235 255  

    -- Function to create a new empty board
createEmptyBoard :: Int -> Board
createEmptyBoard a = array indexRange $ zip (range indexRange) (cycle [Empty])
  where
    indexRange = ((0, 0), (a - 1, a - 1))

getEmptyCells :: Board -> [(Int, Int)]
getEmptyCells board = filter (\coord -> board ! coord == Empty) (indices board)