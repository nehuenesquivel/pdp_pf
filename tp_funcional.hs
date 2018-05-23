-- TP funcional 2018

-- 3.1 Punto 1: Modelar micro 

-- 3.1.1 Modelar el tipo de dato microprocesador.
import Text.Show.Functions 

type Posiciones = [Int]

data Microprocesador = Microprocesador {memoria :: Posiciones,
					instrucciones :: [Microprocesador -> Microprocesador],
                                        acumuladorA :: Int,
                                        acumuladorB :: Int,
                                        programCounter :: Int,
                                        mensajeError :: String
                                       } deriving (Show)



 -- 3.1.2

{-
xt8088 = Microprocesador {memoria = [],
                          acumuladorA = 0,
                          acumuladorB = 0,
                          programCounter = 0,
                          mensajeError = ""
                         }

-} 

-- 3.2 Punto 2

-- 3.2.1


ejecutar :: (Microprocesador -> Microprocesador) -> Microprocesador -> Microprocesador
ejecutar operacion = nopR.operacion


nop :: Microprocesador -> Microprocesador
nop = id

nopR :: Microprocesador -> Microprocesador
nopR microprocesador = microprocesador {programCounter =((+1).programCounter) microprocesador}


{- 3.2.2 Desde la consola, modele un programa que haga avanzar tres posiciones el program counter.
 
> (ejecutar nop.ejecutar nop.ejecutar nop) xt8088
Microprocesador {memoria = [], acumuladorA = 0, acumuladorB = 0, programCounter = 3, mensajeError = ""}

Interviene el concepto de composición de funciones -}


-- 3.3 Punto 3

---3.3.1

lodv :: Int -> Microprocesador -> Microprocesador
lodv valor microprocesador = microprocesador {acumuladorA = valor}

swap :: Microprocesador -> Microprocesador
swap microprocesador = microprocesador {acumuladorA = acumuladorB microprocesador,
              	                        acumuladorB = acumuladorA microprocesador
                                       }

add :: Microprocesador -> Microprocesador		
add microprocesador = microprocesador {acumuladorA = acumuladorA microprocesador + acumuladorB microprocesador,
		                       acumuladorB = 0 
                                      }

  

{- 3.3.2 Implementar un programa que permita sumar 10 + 22

(ejecutar add.ejecutar (lodv 22).ejecutar swap.ejecutar (lodv 10)) xt8088
Microprocesador {memoria = [], acumuladorA = 32, acumuladorB = 0, programCounter = 4, mensajeError = ""}

-}


-- 3.4 Punto 4

-- 3.4.1

divide :: Microprocesador -> Microprocesador
divide microprocesador | acumuladorB microprocesador == 0 = microprocesador {mensajeError = "DIVISION BY ZERO"}
                       | otherwise = microprocesador {acumuladorA = div (acumuladorA microprocesador)(acumuladorB microprocesador),
        	                                      acumuladorB = 0                                              
                                                     }
				

guardarValorEnPosicion :: Int -> Int -> Posiciones -> Posiciones
guardarValorEnPosicion direccion valor memoria = take (direccion - 1) memoria ++ [valor] ++ drop direccion memoria

str :: Int -> Int -> Microprocesador -> Microprocesador
str direccion valor microprocesador = microprocesador {memoria = guardarValorEnPosicion direccion valor (memoria microprocesador)}


sacarElementoPosicion :: Int -> Posiciones -> Int
sacarElementoPosicion direccion memoria | null(memoria) = 0
                                     	  | otherwise = memoria !! (direccion - 1)


lod :: Int -> Microprocesador -> Microprocesador
lod direccion microprocesador = microprocesador {acumuladorA = sacarElementoPosicion direccion (memoria microprocesador)}

{- 3.4.2 Desde la consola, modele un programa que intente dividir 2 por 0

(ejecutar divide.ejecutar (lod 1).ejecutar swap.ejecutar (lod 2).ejecutar (str 2 0).ejecutar (str 1 2)) xt8088

Microprocesador {memoria = [2,0], acumuladorA = 2, acumuladorB = 0, programCounter = 6, mensajeError = "DIVISION BY ZERO"}
-}


{- Casos de prueba

Todas las capturas se encuentran en un archivo llamado casos_de_prueba.docx
-}

{-fp20 = Microprocesador {memoria = [],
                        acumuladorA = 7,
                        acumuladorB = 24,
                        programCounter = 0,
                        mensajeError = ""
                       }

-}

at8086 = Microprocesador {memoria = [1..20],
                          acumuladorA = 7,
                          acumuladorB = 24,
                          programCounter = 0,
                          mensajeError = ""
                       }
 

 
-- Entrega 2 

--3.1 Punto 1: Carga de un programa

--Agregamos un registro en el data para las instrucciones

-- Representar la suma de 10 y 22

xt8088 = Microprocesador {memoria = [],
			  instrucciones = [lodv 10,swap,lodv 22,add],
                          acumuladorA = 0,
                          acumuladorB = 0,
                          programCounter = 0,
                          mensajeError = ""
                         } 

-- Representar la división de 2 por 0

xt8088 = Microprocesador {memoria = [],
			  instrucciones = [str 1 2,str 2 0,lod 2,swap,lod 1,div],
                          acumuladorA = 0,
                          acumuladorB = 0,
                          programCounter = 0,
                          mensajeError = ""
                         } 

 
-- 3.2 Punto 2: Ejecución de un programa.

-- Hicimos para la primera entrega la funcion ejecutar


--- 3.3 Punto 3: IFNZ


fp20 = Microprocesador {memoria = [],
			instrucciones = [lodv 3,swap]
                        acumuladorA = 7,
                        acumuladorB = 24,
                        programCounter = 0,
                        mensajeError = ""
                       }


