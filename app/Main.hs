module Main (main) where
import Graphics.Gloss
import Game
import Rendering
import Logic
import System.Random
import Rendering (drawFullGame)


window :: Display
window = FullScreen

backgroundColor :: Color
backgroundColor = makeColorI 206 233 235 181


initialGame :: Game
initialGame = Game {gameBoard = initialBoard n,
                    gameState = Running,
                    gameScore = 0,
                    bestScore = 0,
                    winningValue = winning,
                    gameStdGen = mkStdGen 42
                    }
                    where indexRange = ((0, 0), (n - 1, n - 1))

main :: IO ()
main = play window backgroundColor 30 initialGame gameAsPicture transformGame (const id)

--main :: IO ()
--main = play window backgroundColor 30 initialGame (\_ -> drawFullGame) transformGame (const id)

