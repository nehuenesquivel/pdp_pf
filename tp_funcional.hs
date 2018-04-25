-- TP funcional 2018

-- 3.1 Punto 1: Modelar micro 

-- 3.1.1 Modelar el tipo de dato microprocesador.
 

type Posiciones = [Int]

data Microprocesador = Microprocesador {memoria :: Posiciones,
                                        acumuladorA :: Int,
                                        acumuladorB :: Int,
                                        programCounter :: Int,
                                        mensajeError :: String
                                       } deriving Show

 -- 3.1.2

xt8088 = Microprocesador {memoria = [],
                          acumuladorA = 0,
                          acumuladorB = 0,
                          programCounter = 0,
                          mensajeError = ""
                         }

 

-- 3.2 Punto 2

--incrementarPC microprocesador = microprocesador {programCounter =((+1).programCounter) microprocesador}

-- 3.2.1
nop microprocesador = microprocesador {programCounter = programCounter microprocesador + 1}

{- 3.2.2 Desde la consola, modele un programa que haga avanzar tres posiciones el program counter.
 
> (nop.nop.nop) xt8088
Microprocesador {memoria = [], acumuladorA = 0, acumuladorB = 0, programCounter = 3, mensajeError = ""}

Interviene el concepto de composición de funciones -}


-- 3.3 Punto 3

---3.3.1

ejecutar operacion = nop.operacion

lodv valor microprocesador = microprocesador {acumuladorA = valor}

swap microprocesador = microprocesador {acumuladorA = acumuladorB microprocesador,
              	                        acumuladorB = acumuladorA microprocesador
                                       }
		
add microprocesador = microprocesador {acumuladorA = acumuladorA microprocesador + acumuladorB microprocesador,
		                                   acumuladorB = 0 
                                      }

  

{- 3.3.2 Implementar un programa que permita sumar 10 + 22

(ejecutar add.ejecutar (lodv 22).ejecutar swap.ejecutar (lodv 10)) xt8088
Microprocesador {memoria = [], acumuladorA = 32, acumuladorB = 0, programCounter = 4, mensajeError = ""}

-}


-- 3.4 Punto 4

-- 3.4.1

divide microprocesador | acumuladorB microprocesador == 0 = microprocesador {mensajeError = "DIVISION BY ZERO"}
                       | otherwise = microprocesador {acumuladorA = div (acumuladorA microprocesador)(acumuladorB microprocesador),
        	                                            acumuladorB = 0,
                                                      mensajeError = ""
                                                     }
				

guardarValorEnPosicion direccion valor memoria  | direccion < 2 && (null(memoria) || null(tail memoria)) = [valor]
                                                | direccion < 2 = [valor] ++ tail memoria
                                                | null(memoria) = [0] ++ guardarValorEnPosicion (direccion - 1) valor memoria
                                                | otherwise = [head memoria] ++ guardarValorEnPosicion (direccion - 1) valor (tail memoria)       

str direccion valor microprocesador = microprocesador {memoria = guardarValorEnPosicion direccion valor (memoria microprocesador)}


sacarElementoPosicion direccion memoria  | null(memoria) = 0
                                         | direccion < 2 = head memoria
                                         | otherwise = sacarElementoPosicion (direccion - 1) (tail memoria)

lod direccion microprocesador = microprocesador {acumuladorA = sacarElementoPosicion direccion (memoria microprocesador)}

{- 3.4.2 Desde la consola, modele un programa que intente dividir 2 por 0

(ejecutar divide.ejecutar (lod 1).ejecutar swap.ejecutar (lod 2).ejecutar (str 2 0).ejecutar (str 1 2)) xt8088

Microprocesador {memoria = [2,0], acumuladorA = 2, acumuladorB = 0, programCounter = 6, mensajeError = "DIVISION BY ZERO"}
-}


{- Casos de prueba

Todas las capturas se encuentran en un archivo llamado casos_de_prueba.xlsx
-}

fp20 = Microprocesador {memoria = [],
                        acumuladorA = 7,
                        acumuladorB = 24,
                        programCounter = 0,
                        mensajeError = ""
                       }


at8086 = Microprocesador {memoria = [1..20],
                          acumuladorA = 7,
                          acumuladorB = 24,
                          programCounter = 0,
                          mensajeError = ""
                       }
 

 

 

 

 

