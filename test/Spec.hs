import Test.HUnit (runTestTT)

import LogicSpec (tests)

main :: IO ()
main = runTestTT tests >> return ()
