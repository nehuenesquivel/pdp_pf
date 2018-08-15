/* 1- */
mira(juan,himym).
mira(juan,futurama).
mira(juan,got).
mira(nico,starWars).
mira(nico,got).
mira(maiu,starWars).
mira(maiu,onePiece).
mira(maiu,got).
mira(gaston,hoc).
mira(pedro,got).

serie(Serie):- episodios(Serie,_,_).
conversacion(Persona,Serie):- leDijo(Persona,_,Serie,_).
conversacion(Persona,Serie):- leDijo(_,Persona,Serie,_).
popularidad(Serie,Popularidad):- serie(Serie), findall(PersonaMira, mira(PersonaMira,Serie), PersonasMiran), 
								 findall(PersonaConversa,conversacion(PersonaConversa,Serie), PersonasConversan),
								 Popularidad is length(PersonasMiran) * length(PersonasConversan).   
popular(got).
popular(hoc).
popular(starWars).
popular(Serie):- popularidad(Serie,Popularidad), popularidad(starWars,PopularidadStarWars), Popularidad >= PopularidadStarWars.

planeaVer(juan,hoc).
planeaVer(aye,got).
planeaVer(gaston,himym).

episodios(got,3,12).
episodios(got,2,10).
episodios(himym,1,23).
episodios(drHouse,8,16).

/* 2- */
%paso(Serie, Temporada, Episodio, Lo que paso)
paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion(amistad, tyrion, dragon)).
paso(got, 3, 2, plotTwist([suenio,sinPiernas])).
paso(got, 3, 12, plotTwist([fuego,boda])).
paso(supercampeones, 9, 9, plotTwist([suenio,coma,sinPiernas])).
paso(drHouse, 8, 7, plotTwist([coma,pastillas])).



%leDijo/4
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)). 
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).
leDijo(nico,juan,futurama,muerte(seymourDiera)).
leDijo(pedro,aye,got,relacion(amistad,tyrion,dragon)).

/* 3- */
esSpoiler(Serie,Spoiler):- paso(Serie,_,_,Spoiler).

/* 4- */
leDijoLoQuePaso(Persona1,Persona2,Serie):- leDijo(Persona1,Persona2,Serie,Spoiler),esSpoiler(Serie,Spoiler).
laVera(Persona,Serie):- mira(Persona,Serie).
laVera(Persona,Serie):- planeaVer(Persona,Serie).
leSpoileo(Persona1,Persona2,Serie):- leDijoLoQuePaso(Persona1,Persona2,Serie), laVera(Persona2,Serie).


/* 5- */
persona(juan).
persona(nico).
persona(gaston).
persona(pedro).
televidenteResponsable(Persona):- persona(Persona), not(leSpoileo(Persona,_,_)).


/* 6- */
laVeraSinSpoileada(Persona,Serie):- laVera(Persona,Serie), not(leSpoileo(_,Persona,Serie)).
vieneZafando(Persona,Serie):- laVeraSinSpoileada(Persona,Serie), popular(Serie).
vieneZafando(Persona,Serie):- laVeraSinSpoileada(Persona,Serie), fuerte(Serie).



esCliche(Serie):- serie(Serie).
fuerte(Serie):- paso(Serie,_,_,muerte(_)).
fuerte(Serie):- paso(Serie,_,_,relacion(amorosa,_,_)).
fuerte(Serie):- paso(Serie,_,_,relacion(parentesco,_,_)).
fuerte(Serie):- serie(Serie), not(esCliche(Serie)), paso(Serie, Temporada, Episodios, plotTwist_),episodios(Serie,Temporada,Episodios).


/**Entrega 2 **/

/* 1-*/

malaGente(Persona1):- persona(Persona1), forall(leDijo(Persona1,Persona2,Serie,_),leSpoileo(Persona1,Persona2,Serie)).
malaGente(Persona1):- persona(Persona2), leSpoileo(Persona1,Persona2,Serie), not(mira(Persona1,Serie)).


/* 2-*/

/* cambiar fuerte(Serie) */


/* 3-*/

/* cambiar popular(Serie) */


/* 4-*/

amigo(nico,maiu).
amigo(maiu,gaston).
amigo(maiu,juan).
amigo(juan,aye).

amigoDelAmigo(Persona1,Persona2):- amigo(Persona1,Persona2).
amigoDelAmigo(Persona1,Persona2):- amigo(Persona1,OtraPersona), amigoDelAmigo(OtraPersona,Persona2).
fullSpoil(Persona1,Persona2):- leSpoileo(Persona1,Persona2,_).
fullSpoil(Persona1,Persona2):- leSpoileo(Persona1,OtraPersona,_), amigoDelAmigo(OtraPersona,Persona2), Persona1 \= Persona2.




