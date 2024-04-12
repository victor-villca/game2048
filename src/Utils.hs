module Utils where
import Graphics.Gloss
boldText :: Float -> Picture -> Picture
boldText offset textPic = pictures
    [ textPic
    , translate offset offset textPic
    , translate (-offset) offset textPic
    , translate offset (-offset) textPic
    , translate (-offset) (-offset) textPic
    ]


numberToPicture :: Int -> Picture
numberToPicture n = translate (-20) (-20) . scale 0.5 0.5 . boldText 1 . text $ show n