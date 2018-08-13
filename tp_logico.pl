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

popular(got).
popular(hoc).
popular(starWars).

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

%leDijo/4
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)). 
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).

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
televidenteResponsable(Persona):- persona(Persona), not(leSpoileo(Persona,_,_)).


/* 6- */
laVeraSinSpoileada(Persona,Serie):- laVera(Persona,Serie), not(leSpoileo(_,Persona,Serie)).
vieneZafando(Persona,Serie):- laVeraSinSpoileada(Persona,Serie), popular(Serie).
vieneZafando(Persona,Serie):- laVeraSinSpoileada(Persona,Serie), pasaronCosasFuertes(Serie).


pasaronCosasFuertes(Serie):- paso(Serie,_,_,muerte(_)).
pasaronCosasFuertes(Serie):- paso(Serie,_,_,relacion(amorosa,_,_)).
pasaronCosasFuertes(Serie):- paso(Serie,_,_,relacion(parentesco,_,_)).


