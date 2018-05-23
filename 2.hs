{- 3.1.1. -}
import Text.Show.Functions
data Microprocessor = Microprocessor {
    dataMemory :: [Int],
    instructionMemory :: [Microprocessor -> Microprocessor],
    accumulatorA :: Int,
    accumulatorB :: Int,
    programCounter :: Int,
    lastErrorMessage :: String
} deriving (Show)
-- xt8088 = Microprocessor {
--     dataMemory = [],
--     instructionMemory = [lodv 10,swap,lodv 22,add],
--     accumulatorA = 0,
--     accumulatorB = 0,
--     programCounter = 0,
--     lastErrorMessage = ""
-- }
-- xt8088 = Microprocessor {
--     dataMemory = [],
--     instructionMemory = [str 1 2,str 2 0,lod 2,swap,lod 1,divide],
--     accumulatorA = 0,
--     accumulatorB = 0,
--     programCounter = 0,
--     lastErrorMessage = ""
-- }
{- 3.2.2. -}
execute :: (Microprocessor -> Microprocessor) -> Microprocessor -> Microprocessor
execute operation microprocessor | lastErrorMessage microprocessor /= "" = microprocessor
                                 | otherwise = (operation.nop) microprocessor
-- foldl (flip execute) microprocessor (instructionMemory microprocessor)
{- 3.3.3. -}
ifnz :: [Microprocessor -> Microprocessor] -> Microprocessor -> Microprocessor
ifnz instructionSeries microprocessor | accumulatorA microprocessor == 0 = microprocessor
                                      | otherwise = foldl (flip execute) microprocessor (instructionSeries)
{- 3.5.5. -}
ordered :: Microprocessor -> Bool
ordered microprocessor = ordered1 (dataMemory microprocessor)
ordered1 :: [Int] -> Bool
ordered1 dataMemory | dataMemory == [] = False
                    | tail dataMemory == [] = True
                    | head dataMemory > (head.tail) dataMemory = False
                    | otherwise = ordered1 (tail dataMemory)
