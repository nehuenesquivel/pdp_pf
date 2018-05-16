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
xt8088 = Microprocessor {
    dataMemory = [],
    instructionMemory = [str 1 2,str 2 0,lod 2,swap,lod 1,divide],
    accumulatorA = 0,
    accumulatorB = 0,
    programCounter = 0,
    lastErrorMessage = ""
}
{- 3.2.2.* -}
-- foldl (flip execute) microprocessor (instructionMemory microprocessor)
{- 3.3.3. -}
{- 3.4.4. -}
debug microprocessor = microprocessor {instructionMemory = debug1 (instructionMemory microprocessor)}
debug1 instructionMemory |
                         |
{- 3.5.5. -}
{- 3.6.6. -}