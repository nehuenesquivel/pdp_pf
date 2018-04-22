-- TP funcional 2018 

-- Punto 1: Modelar micro

-- Modelar el tipo de dato microprocesador. 

type Posiciones = [Int]
data Microprocesador = Microprocesador {memoria :: Posiciones,
				acumuladorA :: Int,
				acumuladorB :: Int,
				programCounter :: Int,
				mensajeError :: String} deriving Show


xt8088 = Microprocesador {memoria = [1,42,85],
			acumuladorA = 10,
			acumuladorB = 2,
			programCounter = 0,
			mensajeError = ""}


-- Punto 2

incrementarPC microprocesador = programCounter microprocesador + 1

nop microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = acumuladorA microprocesador,
			acumuladorB = acumuladorB microprocesador,
			programCounter = incrementarPC microprocesador,
			mensajeError = mensajeError microprocesador}

{- Desde la consola, modele un programa que haga avanzar tres posiciones el program counter.

 > nop(nop(nop xt8088))
 Microprocesador {memoria = [], acumuladorA = 0, acumuladorB = 0, programCounter = 3, mensajeError = ""}

Interviene el concepto de composición de funciones -}



-- Punto 3

lodv valor microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = valor,
			acumuladorB = acumuladorB microprocesador,
			programCounter = incrementarPC microprocesador,
			mensajeError = mensajeError microprocesador}

swap microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = acumuladorB microprocesador,
			acumuladorB = acumuladorA microprocesador,
			programCounter = incrementarPC microprocesador,
			mensajeError = mensajeError microprocesador}

add microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = acumuladorA microprocesador + acumuladorB microprocesador,
			acumuladorB = 0,
			programCounter = incrementarPC microprocesador,
			mensajeError = mensajeError microprocesador}

{- Implementar un programa que permita sumar 10 + 22

> lodv 10 xt8088
Microprocesador {memoria = [], acumuladorA = 10, acumuladorB = 0, programCounter = 1, mensajeError = ""}

> swap(lodv 10 xt8088)
Microprocesador {memoria = [], acumuladorA = 0, acumuladorB = 10, programCounter = 2, mensajeError = ""}

> lodv 22 (swap(lodv 10 xt8088))
Microprocesador {memoria = [], acumuladorA = 22, acumuladorB = 10, programCounter = 3, mensajeError = ""}

> add(lodv 22 (swap(lodv 10 xt8088)))
Microprocesador {memoria = [], acumuladorA = 32, acumuladorB = 0, programCounter = 4, mensajeError = ""}

-}


-- Punto 4

{-divide microprocesador | acumuladorB microprocesador == 0 = Microprocesador {memoria = memoria microprocesador,
								acumuladorA = acumuladorA microprocesador,
								acumuladorB = acumuladorB microprocesador,
								programCounter = incrementarPC microprocesador,
								mensajeError = "Division by zero"}
			| otherwise = Microprocesador {memoria = memoria microprocesador,
						acumuladorA = acumuladorA microprocesador / acumuladorB microprocesador,
						acumuladorB = 0,
						programCounter = incrementarPC microprocesador,
						mensajeError = mensajeError microprocesador}


-}

sacarElementoPosicion addr memoria = memoria !! (addr - 1)

{-lod addr microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = sacarElementoPosicion addr memoria microprocesador,
			acumuladorB = acumuladorB microprocesador,
			programCounter = incrementarPC microprocesador,
			mensajeError = mensajeError microprocesador}

-}







 
