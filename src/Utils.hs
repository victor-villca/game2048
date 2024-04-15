module Utils where
import Graphics.Gloss

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