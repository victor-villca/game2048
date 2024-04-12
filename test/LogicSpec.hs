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

testMergeCells :: Test
testMergeCells = TestCase $ do
    let test1 = mergeCells [Empty, Empty, Ocuppied 2, Empty]
    assertEqual "Debe fusionar las celdas vacías con la misma ocupación" [Empty, Empty, Ocuppied 2, Empty] test1
    
    let test2 = mergeCells [Ocuppied 2, Empty, Ocuppied 2, Empty]
    assertEqual "Debe fusionar las celdas ocupadas con la misma ocupación" [Ocuppied 4, Empty, Empty, Empty] test2
    
    let test3 = mergeCells [Ocuppied 2, Ocuppied 2, Ocuppied 4, Ocuppied 4]
    assertEqual "Debe fusionar las celdas ocupadas con la misma ocupación" [Ocuppied 4, Ocuppied 8, Empty, Empty] test3

testGetValue :: Test
testGetValue = TestCase $ do
    let test1 = getValue Empty
    assertEqual "El valor de una celda vacía debe ser 0" 0 test1
    
    let test2 = getValue (Ocuppied 2)
    assertEqual "El valor de una celda ocupada debe ser su valor" 2 test2
    
    let test3 = getValue (Ocuppied 10)
    assertEqual "El valor de una celda ocupada debe ser su valor" 10 test3
    
-- Ejecutar las pruebas
mainLogic :: IO Counts
mainLogic = runTestTT tests
