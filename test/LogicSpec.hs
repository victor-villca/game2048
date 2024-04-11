module LogicSpec where

import Test.HUnit
import Logic
import Game

-- Prueba para verificar si la función createEmptyBoard devuelve un tablero vacío del tamaño especificado
testCreateEmptyBoard :: Test
testCreateEmptyBoard = TestCase $ do
    let board = createEmptyBoard 3
    assertEqual "El tablero debe ser de tamaño 3x3" (bounds board) ((0,0),(2,2))
    assertEqual "Todas las celdas deben ser Empty" (elems board) (replicate 9 Empty)

-- Prueba para verificar si la función initializeBoard coloca dos fichas en un tablero vacío
testInitializeBoard :: Test
testInitializeBoard = TestCase $ do
    let emptyBoard = createEmptyBoard 3
    board <- initializeBoard emptyBoard
    let occupiedCount = length . filter (\case { Occupied _ -> True; _ -> False }) . elems $ board
    assertEqual "Debe haber dos celdas ocupadas en el tablero" 2 occupiedCount

-- Prueba para verificar si la función createAndPopulateBoard devuelve un tablero con dos fichas colocadas
testCreateAndPopulateBoard :: Test
testCreateAndPopulateBoard = TestCase $ do
    board <- createAndPopulateBoard 3
    let occupiedCount = length . filter (\case { Occupied _ -> True; _ -> False }) . elems $ board
    assertEqual "Debe haber dos celdas ocupadas en el tablero" 2 occupiedCount

-- Definir la suite de pruebas
tests :: Test
tests = TestList
    [ TestLabel "testCreateEmptyBoard" testCreateEmptyBoard
    , TestLabel "testInitializeBoard" testInitializeBoard
    , TestLabel "testCreateAndPopulateBoard" testCreateAndPopulateBoard
    ]

-- Ejecutar las pruebas
mainLogic :: IO Counts
mainLogic = runTestTT tests
