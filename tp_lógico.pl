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
/* 2 */
paso(futurama,2,3,muerte(seymourDiera)).
paso(starWars,10,9,muerte(emperor)).
paso(starWars,1,2,relacion(parentesco,anakin,rey)).
paso(starWars,3,2,relacion(parentesco,vader,luke)).
paso(himym,1,1,relacion(amorosa,ted,robin)).
paso(himym,4,3,relacion(amorosa,swarley,robin)).
paso(got,4,5,relacion(amistad,tyrion,dragon)).
leDijo(gaston,maiu,got,relacion(amistad,tyrion,dragon)).
leDijo(nico,maiu,starWars,relacion(parentesco,vader,luke)).
leDijo(nico,juan,got,muerte(tyrion)).
leDijo(aye,juan,got,relacion(amistad,tyrion,john)).
leDijo(aye,maiu,got,relacion(amistad,tyrion,john)).
leDijo(aye,gaston,got,relacion(amistad,tyrion,dragon)).
/* 3- */
esSpoiler(Serie,Spoiler):- paso(Serie,A,B,Spoiler).
/* 4- */
leSpoileo(Persona1,Persona2,Serie):- leDijo(Persona1,Persona2,Serie,C),mira(Persona2,Serie).
leSpoileo(Persona1,Persona2,Serie):- leDijo(Persona1,Persona2,Serie,C),planeaVer(Persona2,Serie).
/* 5 */
televidente(juan).
televidente(nico).
televidente(maiu).
televidente(gaston).
televidente(aye).
televidenteResponsable(Persona):- not(leSpoileo(Persona,D,E)).
televidenteResponsable(Persona):- televidente(Persona),not(leSpoileo(Persona,D,E)).
/* 6 */
vieneZafando(Persona,Serie):- not(leSpoileo(F,Persona,Serie)).
