{- 3.1.1.* -}
data Microprocessor = Microprocessor {
	dataMemory :: [Int],
	accumulatorA :: Int,
	accumulatorB :: Int,
	programCounter :: Int,
    lastErrorMessage :: String
} deriving (Show)
{- 3.1.2. -}
xt8088 = Microprocessor {
	dataMemory = [],
	accumulatorA = 0,
	accumulatorB = 0,
	programCounter = 0,
    lastErrorMessage = ""
}
{- 3.2.1.* -}
nop microprocessor = Microprocessor {
	dataMemory = dataMemory microprocessor,
	accumulatorA = accumulatorA microprocessor,
	accumulatorB = accumulatorB microprocessor,
	programCounter = programCounter microprocessor + 1,
    lastErrorMessage = lastErrorMessage microprocessor
}
{- 3.2.2. -}
-- (nop.nop.nop) xt8088
{- 3.3.1 -}
lodv value microprocessor = Microprocessor {
	dataMemory = dataMemory microprocessor,
	accumulatorA = value,
	accumulatorB = accumulatorB microprocessor,
	programCounter = programCounter microprocessor,
    lastErrorMessage = lastErrorMessage microprocessor
}
swap microprocessor = Microprocessor {
	dataMemory = dataMemory microprocessor,
	accumulatorA = accumulatorB microprocessor,
	accumulatorB = accumulatorA microprocessor,
	programCounter = programCounter microprocessor,
    lastErrorMessage = lastErrorMessage microprocessor
}
add microprocessor = Microprocessor {
	dataMemory = dataMemory microprocessor,
	accumulatorA = accumulatorA microprocessor + accumulatorB microprocessor,
	accumulatorB = 0,
	programCounter = programCounter microprocessor,
    lastErrorMessage = lastErrorMessage microprocessor
}
{- 3.3.2. -}
-- (add.nop.(lodv 22).nop.swap.nop.(lodv 10).nop) xt8088