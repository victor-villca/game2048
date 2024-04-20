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


    -- Function to create a new empty board
createEmptyBoard :: Int -> Board
createEmptyBoard a = array indexRange $ zip (range indexRange) (cycle [Empty])
  where
    indexRange = ((0, 0), (a - 1, a - 1))

getEmptyCells :: Board -> [(Int, Int)]
getEmptyCells board = filter (\coord -> board ! coord == Empty) (indices board)