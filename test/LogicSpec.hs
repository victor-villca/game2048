{-# LANGUAGE LambdaCase #-}  

module LogicSpec where

import Test.HUnit
import Logic
import Game
import Data.Array 

-- Prueba para verificar si la función createEmptyBoard devuelve un tablero vacío del tamaño especificado
testCreateEmptyBoard :: Test
testCreateEmptyBoard = TestCase $ do
    let board = createEmptyBoard 3
    assertEqual "El tablero debe ser de tamaño 3x3" (bounds board) ((0,0),(2,2))
    assertEqual "Todas las celdas deben ser Empty" (elems $ board) (replicate 9 Empty)

-- Definir la suite de pruebas
tests :: Test
tests = TestList
    [ TestLabel "testCreateEmptyBoard" testCreateEmptyBoard
    ]

-- Ejecutar las pruebas
mainLogic :: IO Counts
mainLogic = runTestTT tests
