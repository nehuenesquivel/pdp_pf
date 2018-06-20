{- 3.2.2 -}
execute :: (Microprocessor -> Microprocessor) -> Microprocessor -> Microprocessor
execute operation microprocessor | (/="") (lastErrorMessage microprocessor) = microprocessor
                                 | otherwise = (operation.nop) microprocessor
-- foldl (flip execute) microprocessor (instructionMemory microprocessor)
{- 3.3.3 -}
ifnz :: [Microprocessor -> Microprocessor] -> Microprocessor -> Microprocessor
ifnz instructionSeries microprocessor | (==0) (accumulatorA microprocessor) = microprocessor
                                      | otherwise = foldl (flip execute) microprocessor (instructionSeries)
{- 3.5.5 -}
ordered :: Microprocessor -> Bool
ordered microprocessor = ordered1 (dataMemory microprocessor)
ordered1 :: [Int] -> Bool
ordered1 [] = True
ordered1 [first] = True
ordered1 (first:second:third) = first < second && ordered1 (second:third)
{- 3.6.6. -}
-- xt8088 = Microprocessor {
--     dataMemory = [0..],
--     instructionMemory = [],
--     accumulatorA = 0,
--     accumulatorB = 0,
--     programCounter = 0,
--     lastErrorMessage = ""
-- }
