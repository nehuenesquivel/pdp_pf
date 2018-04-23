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
{- 3.4.1 -}
divide microprocessor = Microprocessor {
	dataMemory = dataMemory microprocessor,
	accumulatorA = divide1 (accumulatorA microprocessor) (accumulatorB microprocessor),
	accumulatorB = 0,
	programCounter = programCounter microprocessor,
    lastErrorMessage = divide2 (lastErrorMessage microprocessor) (accumulatorB microprocessor)
}
divide1 accumulatorA accumulatorB | accumulatorB == 0 = 0
                                  | otherwise = div accumulatorA accumulatorB
divide2 lastErrorMessage accumulatorB | accumulatorB == 0 = "DIVISION BY ZERO"
                                      | otherwise = lastErrorMessage
str address value microprocessor = Microprocessor {
	dataMemory = str1 address value (dataMemory microprocessor),
	accumulatorA = accumulatorA microprocessor,
	accumulatorB = accumulatorB microprocessor,
	programCounter = programCounter microprocessor,
    lastErrorMessage = lastErrorMessage microprocessor
}
str1 address value dataMemory | address < 2 && (null(dataMemory) || null(tail dataMemory)) = [value]
                              | address < 2 = [value] ++ tail dataMemory
                              | null(dataMemory) = [0] ++ str1 (address - 1) value dataMemory
                              | otherwise = [head dataMemory] ++ str1 (address - 1) value (tail dataMemory)
lod address microprocessor = Microprocessor {
	dataMemory = dataMemory microprocessor,
	accumulatorA =  lod1 address (dataMemory microprocessor),
	accumulatorB = accumulatorB microprocessor,
	programCounter = programCounter microprocessor,
    lastErrorMessage = lastErrorMessage microprocessor
}
lod1 address dataMemory | null(dataMemory) = 0
                        | address < 2 = head dataMemory
                        | otherwise = lod1 (address - 1) (tail dataMemory)
{- 3.4.2. -}
-- (divide.nop.(lod 1).nop.swap.nop.(lod 2).nop.(str 2 0).nop.(str 1 2).nop) xt8088
