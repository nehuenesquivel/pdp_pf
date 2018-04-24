-- TP funcional 2018 

-- Punto 1: Modelar micro

-- Modelar el tipo de dato microprocesador. 

type Posiciones = [Int]
data Microprocesador = Microprocesador {memoria :: Posiciones,
				acumuladorA :: Int,
				acumuladorB :: Int,
				programCounter :: Int,
				mensajeError :: String} deriving Show


xt8088 = Microprocesador {memoria = [],
			acumuladorA = 0,
			acumuladorB = 0,
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

 > (nop.nop.nop) xt8088
 Microprocesador {memoria = [], acumuladorA = 0, acumuladorB = 0, programCounter = 3, mensajeError = ""}

Interviene el concepto de composición de funciones -}



-- Punto 3

lodv valor microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = valor,
			acumuladorB = acumuladorB microprocesador,
			programCounter = programCounter microprocesador,
			mensajeError = mensajeError microprocesador}

swap microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = acumuladorB microprocesador,
			acumuladorB = acumuladorA microprocesador,
			programCounter = programCounter microprocesador,
			mensajeError = mensajeError microprocesador}

add microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = acumuladorA microprocesador + acumuladorB microprocesador,
			acumuladorB = 0,
			programCounter = programCounter microprocesador,
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

lala = Microprocesador {memoria = [2,4,5,9], acumuladorA = 32, acumuladorB = 2, programCounter = 4, mensajeError = ""}

divide microprocesador | acumuladorB microprocesador == 0 = Microprocesador {memoria = memoria microprocesador,
								acumuladorA = acumuladorA microprocesador,
								acumuladorB = acumuladorB microprocesador,
								programCounter = programCounter microprocesador,
								mensajeError = "Division by zero"}
			| otherwise = Microprocesador {memoria = memoria microprocesador,
						acumuladorA = div (acumuladorA microprocesador)(acumuladorB microprocesador),
						acumuladorB = 0,
						programCounter = programCounter microprocesador,
						mensajeError = mensajeError microprocesador}




sacarElementoPosicion direccion memoria = memoria !! (direccion - 1)

lod direccion microprocesador = Microprocesador {memoria = memoria microprocesador,
			acumuladorA = sacarElementoPosicion direccion (memoria microprocesador),
			acumuladorB = acumuladorB microprocesador,
			programCounter = incrementarPC microprocesador,
			mensajeError = mensajeError microprocesador}









 
