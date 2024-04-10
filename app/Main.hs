module Main (main) where
import Graphics.Gloss

window :: Display
window = InWindow "Game 2048" (1200, 900) (50, 50)

backgroundColor :: Color
backgroundColor = makeColor 255 255 255 255

main :: IO ()
main = display window backgroundColor (Text "Game 2048")
