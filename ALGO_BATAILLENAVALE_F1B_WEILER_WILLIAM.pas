{
	
//BUT:Le jeu de la bataille Navale
//ENTREE:2 coordonnes
//SORTIE:affiche si les coordonnes touche un bateau




CONST
	MAX = 10  					//tailles du terrain
	BATMAX = 5  				//nombres de navires MAX=8
	TMAX = 6  				//tailles des navires MAX=10
VAR
	
	poscell : tabcell
	CelluleAuche : tabcell
	bateau : Tabbat
	Nom : TabNom
	tailleB : Tab
	
	essemble : TabFlotte
	x1 : ENTIER
	y1 : ENTIER
	i : ENTIER
	k : ENTIER
	j : ENTIER
	nbr : ENTIER
	y : CHAR
	x : CHAINE
	test : BOOLEEN


Type
	cellule = ENREGISTREMENT
		ligne : ENTIER
		colonne : ENTIER
	FINENREGISTREMENT
	
Type
	navire = ENREGISTREMENT
		n : cellule
		taille : ENTIER
		nom : CHAINE
	FINENREGISTREMENT
	
Type
	flotte = ENREGISTREMENT
		n1 : navire
	FINENREGISTREMENT


Type
	tabcell = TABLEAU [1..100] DE cellule
	Tabbat = TABLEAU [1..100] DE navire
	TabFlotte = TABLEAU [1..BATMAX,1..100] DE flotte
	TabNom = TABLEAU [1..8] DE CHAINE
	Tab = TABLEAU [1..20] DE ENTIER
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Initialisation a 0 des position des cellules
//ENTREE:1 tableau d'entier (1 entier 1 constante)
//SORTIE:1 tableau d'entier avec valeur 0

PROCEDURE Initabcell(VAR poscell,CelluleAuche:tabcell)

VAR
	i : ENTIER
	
DEBUT
	POUR i <- 1 A MAX FAIRE
		poscell[i].colonne <- 0
		poscell[i].ligne <- 0
		CelluleAuche[i].colonne <- 0
		CelluleAuche[i].ligne <- 0
	FINPOUR
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Initialisation a 0 de la flotte
//ENTREE:2 tableau avec 1 sous type TabFlotte et 1 sous type Tabbat
//SORTIE:2 tableau avec valeur 0

PROCEDURE IniTabFlotte(VAR Bateau:Tabbat  VAR essemble:TabFlotte)
VAR
	i : ENTIER
	j : ENTIER
DEBUT
	POUR i DE 1 A MAX FAIRE
		Bateau[i].n.colonne <- 0 // initialisation  a 0 
		Bateau[i].n.ligne <- 0
		POUR j DE 1 A BATMAX FAIRE
			essemble[j&i].n1.n.colonne <- 0
			essemble[j&i].n1.n.ligne <- 0
		FINPOUR
	FINPOUR
FIN
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Affiche la map du jeu
//ENTREE:3 entier
//SORTIE:affichage

PROCEDURE AfficheMap()
VAR
	cpt : ENTIER
	i : ENTIER
	j : ENTIER

DEBUT
		cpt<-7
	POUR i<-1 A MAX FAIRE		//Afficher 1-10 horizontal
		
	POUR i DE 1 A MAX FAIRE		//Affiche 1-10 vertical
		POUR j DE 1 A MAX*3 FAIRE
			FINPOUR
		
FIN

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:remplace le texte par un espace 
//ENTREE:2 entier
//SORTIE:affichage

PROCEDURE Clrtxt2()

VAR
	
	i : ENTIER
	j : ENTIER
DEBUT

	POUR i DE 13 A 29 FAIRE
		POUR j DE 49 A 71 FAIRE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:remplace le texte par un espace
//ENTREE:2 entier
//SORTIE:affichage

PROCEDURE Clrtxt3()

VAR
	i : ENTIER
	j : ENTIER
DEBUT

	POUR i DE 34 A 35 FAIRE
		POUR j DE 49 A 85 FAIRE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Test les cases suivante dans la direction X pour chaque taille d'un bateau
//ENTREE:1 tableau type Tabbat  1 tableau type tabcell 5 entier& 2 BOOLEEN
//SORTIE:1 BOOLEEN

FONCTION TestCaseLigne(Bateau:Tabbat ; poscell:tabcell x,y,i:ENTIER) DE BOOLEEN

VAR
	j : ENTIER
	test : BOOLEEN
	test2 : BOOLEEN
	
DEBUT
	test <- FAUX
	test2 <- VRAI
	POUR j DE 1 A Bateau[i].taille FAIRE			//Si la cellule bateau y <> de la position y Et que la cellule bateau x <> de la position x +j
		SI (Bateau[j].n.colonne<>poscell[y].colonne) ET (Bateau[j].n.ligne<>poscell[(x+(j-1))].ligne) ALORS
			test <- VRAI 	
		FINSI
		SI test = FAUX ALORS
			test2 <- FAUX
		FINSI
	FINPOUR
	
	SI test2 = FAUX ALORS
		test <- FAUX
	FINSI
	
TestCaseLigne<-test

FIN
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Test les cases suivante dans la direction y pour chaque taille d'un bateau
//ENTREE:1 tableau type Tabbat& 1 tableay type tabcell&5 entier& 2 BOOLEEN
//SORTIE:1 BOOLEEN

FONCTION TestCaseColonne(Bateau:Tabbat ; poscell:tabcell x ,y,i:ENTIER):BOOLEEN

VAR
	j:ENTIER
	test : BOOLEEN
	test2 : BOOLEEN

DEBUT

	test <- FAUX 	
	POUR j DE 1 A Bateau[i].taille FAIRE
		SI (Bateau[j].n.colonne<>poscell[(y+(j-1))].colonne) ET (Bateau[j].n.ligne<>poscell[x].ligne) ALORS
			test <- VRAI 	
		FINSI		
		SI test = FAUX ALORS
			test2 <- FAUX
		FINSI
	FINPOUR
	
	SI test2 = FAUX ALORS
		test <- FAUX
	FINSI

	TestCaseColonne <- test

FIN
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Test pour que les bateaux de se superpose pas
//ENTREE:1 tableau type Tabbat&1 tableau type TabFlotte& 4 entier& 1 booleen
//SORTIE:1 BOOLEEN

FONCTION TestCase(Bateau:Tabbat ; essemble:TabFlotte):BOOLEEN

VAR
	i : ENTIER
	j : ENTIER
	l : ENTIER
	k : ENTIER
	test : BOOLEEN

DEBUT
	test <- VRAI
	
	POUR i DE 1 A BATMAX FAIRE
		POUR j DE 1 A BATMAX FAIRE
			POUR k DE 1 A Bateau[i].taille FAIRE
				POUR l DE 1 A Bateau[i].taille FAIRE
					SI (essemble[i&k].n1.n.ligne=essemble[j&l].n1.n.ligne) ET (essemble[i&k].n1.n.colonne=essemble[j&l].n1.n.colonne) ET (j<>i) ALORS
						test <- FAUX
					FINSI
				FINPOUR
			FINPOUR
		FINPOUR
	FINPOUR
	
	TestCase <- test
FIN


//BUT:converti les chaine (caractere) en entier (Ex:'10'>10)
//ENTREE:1 CHAINE
//SORTIE:1 entier

FONCTION convertisseur1(car:CHAINE):ENTIER

DEBUT
		SI longueur(car) = 1 ALORS
			SI(ord(car[1]) >= 48) ET (ord(car[1]) <= 57) ALORS
		 		convertisseur1<-ord(car[1])-48
			SINON
				convertisseur1 <- 0
			FINSI
		FINSI
			SI longueur(car)=2 ALORS
				SI (ord(car[1]) = 49) ET (ord(car[2]) = 48)ALORS
					convertisseur1 <- 10
				SINON
					convertisseur1 <- 0
				FINSI
		FINSI
			
			
FIN

//BUT:convertir les caractere en entier
//ENTREE:1 caractere
//SORTIE:1 entier

FONCTION convertisseur2(car:CHAR):ENTIER

DEBUT
	SI(ord(car) >= 97 ) ET (ord(car) < 97+MAX) ALORS
		convertisseur2 <- ord(car)-96
	SINON
		convertisseur2 <- 11
	FINSI
FIN
//

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Test Si les coord entrer existe
//ENTREE:1 tableau type TabFlotte& 1 tableau type tabbat& 1 tableau type TabCellule& 3 entier
//SORTIE:1 BOOLEEN

FONCTION trouver(essemble:TabFlotte ; Bateau:tabbat ; poscell:TabCellule x,y:ENTIER VAR nbr:ENTIER):BOOLEEN

VAR
	i : ENTIER
	j : ENTIER
	test : BOOLEEN

DEBUT
	test <- FAUX
	POUR i DE 1 A BOATMAX FAIRE
		POUR j DE 1 A Bateau[i].taille FAIRE
			SI (essemble[i&j].n1.n.colonne=poscell[y].colonne) ET (essemble[i&j].n1.n.ligne=poscell[x].ligne) ALORS
				test <- VRAI
				nbr <- i 														//Si la position entree = a la position du bateau
			FINSI
		FINPOUR
	FINPOUR
	
	trouver <- test
FIN

//BUT:Test si tout les bateau on coule
//ENTREE:1 tableau type T
//SORTIE:1 BOOLEEN

FONCTION final(Nb:Tab):BOOL

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Test si tout les bateau on coule
//ENTREE:1 tableau type T
//SORTIE:1 BOOLEEN

FONCTION final(Nb:Tab):BOOLEEN

VAR
	i : ENTIER
	cpt : ENTIER
	test : BOOLEEN
	
DEBUT
	test <- FAUX
	cpt <- 0
	POUR i DE 1 A BATMAX FAIRE
		SI Nb[i]<1 ALORS
			cpt <- cpt+1
			SI cpt = BATMAX ALORS
				test<-VRAI
			FINSI
		FINSI
	FINPOUR
	
	final <- test

FIN

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Affecte les valeur x y a Pos
//ENTREE:1 tableau type poscell& 2 entier
//SORTIE:Tableau N valeur

PROCEDURE CreateCellule(VAR poscell:tabcell)

VAR
	cpt&i:ENTIER
	
DEBUT	
	
	cpt <- 7
	POUR i DE 1 A MAX FAIRE						//Valeur des cases y
		poscell[i].ligne <- cpt
		cpt<-cpt+4
	FINPOUR

	cpt<-8
	POUR i DE 1 A MAX FAIRE						//Valeur des cases x
		poscell[i].colonne <- cpt
		cpt <- cpt+3
	FINPOUR
FIN
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Affecte les valeur des cellules a bateau
//ENTREE:1 tableau type tabcell& 1 tableau type Tabbat& 4 entier& 1 BOOLEEN
//SORTIE:1 tableau N cellule

PROCEDURE CreateNavire (poscell:tabcell; VAR Bateau:Tabbat i:ENTIER)

VAR
	j : ENTIER
	x : ENTIER
	y : ENTIER
	randdirection : ENTIER
	test : BOOLEEN

DEBUT

	REPETER
	Randomize
			
		randDirection <- Random(2)+1				 					//Pour choisir le positionnement au hasard
	
		cas randDirection PARMIS
			CAS1 :	DEBUT												//Positionnement bateau vertical
		
						REPETE
							x <- Random(MAX)+1 							//positionnement au hasard
							y<-Random(MAX)+1
						JUSQUA (y<=MAX-Bateau[i].taille)
						FINREPETER
					
						test<-TestCaseColonne(Bateau&poscell&x&y&i) 	//test si les cases sont vide pour le bateau
					
						SI test = VRAI ALORS					
							POUR j de 1 A Bateau[i].taille FAIRE						
								Bateau[j].n.colonne <- poscell[(y+j)-1].colonne
								Bateau[j].n.ligne <- poscell[x].ligne
							FINPOUR						
						FINSI					
					FIN
			
			CAS2 :	DEBUT												//Positionnement horizontal
			
					REPETER
						x<-Random(MAX)+1 								//positionnement au hasard
						y<-Random(MAX)+1
					JUSQUA (x <= MAX-Bateau[i].taille)
					
					test <- TestCaseLigne(Bateau&poscell&x&y&i) 		//test si les cases sont vide pour le bateau
					SI test = VRAI ALORS
						POUR j<-1 A Bateau[i].taille FAIRE
							Bateau[j].n.colonne <- poscell[y].colonne
							Bateau[j].n.ligne <- poscell[(x+j)-1].ligne
						FINPOUR
					FINSI
				FIN
		FINCAS
	JUSQUA (test=VRAI)

FIN
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:deFINi la taille d'un bateau
//ENTREE:1 tableau type Tabbat& un tableau typea T& 2 entier
//SORTIE:un tableau type T avec N entier

PROCEDURE TailleBateau(VAR Bateau:Tabbat ; VAR tailleB:Tab)

VAR
	i : ENTIER
	nbr : ENTIER
	
DEBUT
	
	Randomize
	
	POUR i DE 1 A BATMAX FAIRE
		REPETER
			nbr <- Random(TMAX)+1
		JUSQUA nbr > 1
		
		Bateau[i].taille <- nbr
		tailleB[i] <- Bateau[i].taille
	FINPOUR

FIN
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//BUT:Affecte les valeurs des bateaux a la flotte
//ENTREE:1 tableau type Tabbat& 1 tableau type tabcell& 1 tableau type essemble&2 entier& 1 BOOLEEN
//SORTIE:Tableau type TabFlotte avec N valeur entier

PROCEDURE CreateFlotte (Bateau:Tabbat ; poscell:tabcell ; VAR essemble:TabFlotte)

VAR
	i : ENTIER
	j : ENTIER
	test : BOOLEEN
	
DEBUT
	REPETER
		IniTabFlotte(Bateau&essemble)
		
		POUR i DE 1 A BATMAX FAIRE
			CreateNavire(poscell&Bateau&i)
			POUR j DE 1 A Bateau[i].taille FAIRE	
					essemble[i&j].n1.n.ligne <- Bateau[j].n.ligne
					essemble[i&j].n1.n.colonne <- Bateau[j].n.colonne
			FINPOUR
		FINPOUR

		test <- TestCase(Bateau,essemble)
	JUSQUA (test=VRAI)

FIN
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	//DEBUT programme principal
VAR
	
	poscell : tabcell
	CelluleAuche : tabcell
	bateau : Tabbat
	Nom : TabNom
	tailleB : Tab
	
	essemble : TabFlotte
	x1 : ENTIER
	y1 : ENTIER
	i : ENTIER
	k : ENTIER
	j : ENTIER
	nbr : ENTIER
	y : CHAR
	x : CHAINE
	test : BOOLEEN


DEBUT	
	
	IniTabCellule(poscell&CelluleAuche) 														// Init des cellules

	AfficheMap() 																				//affiche le terrain
	
	CreateCellule(poscell) 																	//créer les cellules

	TailleBateau(Bateau&tailleB) 																//defini le nombre de cellule des bateau
	
	CreateFlotte(Bateau&poscell&essemble) 													//creer la flotte de bateau
	

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------					//AfficherFlotte(Bateau et tailleB)
	
	REPETER															//boucle FIN du jeu

			REPETER										//boucle coord x
				
				ECRIRE 'Coordonne x ? 1-10'
				LIRE x
				x1 <- convertisseur1(x)
				SI (x1=0) ALORS
					
						ECRIRE' '
					FINPOUR
				FINSI
			JUSQUA (x1 <> 0) ET (x <> '')
			clrtxt3
			
			REPETER									//boucle coord y
				
				LIRE y
				y <- LowerCase(y)
				y1 <- convertisseur2(y)
				SI (y1=11) ALORS
					
					FINPOUR
				FINSI
			JUSQUA (y1 <> 11)
		
					//si les valeur corresponde
		test <- trouver(essemble & Bateau & poscell & x1 & y1 & nbr)
		SI test=VRAI ALORS															//si les cellule Auche est differente de la cellule donne
			SI (CelluleAuche[nbr].ligne <> poscell[x1].ligne) OU (CelluleAuche[nbr].colonne <> poscell[y1].colonne) ALORS				
				SI (tailleB[nbr]>0) ALORS
					CelluleAuche[nbr].ligne <- poscell[x1].ligne
					CelluleAuche[nbr].colonne <- poscell[y1].colonne
					CRIRE'X'
					
					ECRIRE(Nom[nbr] & ' Aucher !')
					tailleB[nbr] <- tailleB[nbr]-1
				FINSI 			
				SI tailleB[nbr] <= 0 ALORS											//si bateau detruit
					
					ECRIRE 'vous avez coule un navire !'
					POUR i DE 1 A Bateau[nbr].taille FAIRE
					ECRIRE 'C'
					FINPOUR
					tailleB[nbr] <- (-1)
				FINSI
			FINSI
		SINONSI
			IRE '0'
		FINSI
		
		clrtxt2
												//AfficherFlotte(Bateau et tailleB)
			
		test<-final(tailleB)					 // test si tout les bateau detruit
	JUSQUA test=VRAI 							//FIN du jeu
	
	clrtxt3
	
	ECRIRE 'FIN de la partie '
FIN.}


program Bataille_navale;

uses crt;

CONST
	MAX = 10 ;					//taille de la map
	BATMAX = 5 ;				//nombre de navire MAX=8
	TMAX = 6 ;				//taille des navires MAX=10

//BEGIN type
Type
	cellule = record
		ligne : INTEGER ;
		colonne : INTEGER ;
	END ;
	
Type
	navire = record
		n : cellule ;
		taille : INTEGER ;
		nom : STRING ;
	END ;
	
Type
	flotte = record
		n1 : navire ;
	END ;
	


Type
	tabcell = array [1..100] of cellule ;
	tabat = array[1..100] of navire ;
	TabFlotte = array[1..BATMAX,1..100] of flotte ;
	TabNom = array[1..8] of STRING ;
	Tab = array[1..20] of INTEGER ;
// END type


	//init tableau
//BUT:Initialisation a 0 des position des cellules
//ENTREE:1 tableau d'entier, 1 entier, 1 constante
//SORTIE:1 tableau d'entier avec valeur 0
PROCEDURE Initabcell(VAR poscell,celltouche:tabcell);

VAR
	i : INTEGER ;
	
BEGIN
	FOR i := 1 TO MAX DO
	BEGIN
		poscell[i].colonne := 0 ;
		poscell[i].ligne := 0 ;
		celltouche[i].colonne := 0 ;
		celltouche[i].ligne := 0 ;
	END;
END;
//


//BUT:Initialisation a 0 de la flotte
//ENTREE:2 tableau avec 1 sous type TabFlotte, et 1 sous type tabat
//SORTIE:2 tableau avec valeur 0
PROCEDURE IniTabFlotte(VAR Bateau:tabat; VAR enssemble:TabFlotte);
VAR
	i : INTEGER ;
	j : INTEGER ;
BEGIN
	FOR i:=1 TO MAX DO
	BEGIN
		Bateau[i].n.colonne:=0;
		Bateau[i].n.ligne:=0;
		FOR j:=1 TO BATMAX DO
		BEGIN
			enssemble[j,i].n1.n.colonne:=0;
			enssemble[j,i].n1.n.ligne:=0;
		END;
	END;
END;
//
	//END init	
	
	
	//TOutes les PROCEDUREs d'affichage
//BUT:Affiche la map du jeu
//ENTREE:3 entier
//SORTIE:affichage
PROCEDURE AfficheMap();
VAR
	cpt,i,j:INTEGER;

BEGIN
		cpt:=7;
	FOR i:=1 TO MAX DO		//Afficher 1-10 horizontal
	BEGIN
		WRITE(i);
		cpt:=cpt+4;
	END;
	
	
	cpt:=8;
	FOR i:=1 TO MAX DO		//Affiche 1-10 vertical
	BEGIN
		FOR j:=1 TO MAX*3 DO
	
		cpt:=cpt+3;
	END;
		
END;
	//toute les PROCEDURES pour remplacer par un espace les textes

//BUT:remplace le texte par des espaces
//ENTREE:2 entiers
//SORTIE:affichage
PROCEDURE clrtxt();
VAR
	i,j:INTEGER;
BEGIN

	FOR i:=13 TO 29 DO
	BEGIN
		FOR j:=49 TO 71 DO
		
	END;

END;


//BUT:remplace le texte par des espaces
//ENTREE:2 entiers
//SORTIE:affichage
PROCEDURE clrtxt2();
VAR
	i,j:INTEGER;
BEGIN

	FOR i:=34 TO 35 DO
	BEGIN
		FOR j:=49 TO 85 DO
		
	END;

END;
	//END texte


	// les fonctions test
//BUT:Test les cases suivantes dans la direction X pour chaque taille d'un bateau
//ENTREE:1 tableau type tabat, 1 tableau type tabcell,5 entiers, 2 BOOLEENS
//SORTIE:1 BOOLEAN
FUNCTION TestCaseLigne(Bateau:tabat;poscell:tabcell;x,y,i:INTEGER):BOOLEAN;
VAR
	j:INTEGER;
	test,test2:BOOLEAN;
BEGIN
	test:=false;
	test2:=true;
	FOR j:=1 TO Bateau[i].taille DO
	BEGIN
		//Si la cellule bateau y <> de la position y Et que la cellule bateau x <> de la position x +j
		IF (Bateau[j].n.colonne<>poscell[y].colonne) AND (Bateau[j].n.ligne<>poscell[(x+(j-1))].ligne) THEN
		BEGIN
			test:=true;	
		END;
		
		IF test=false THEN
		BEGIN
			test2:=false;
		END;
	END;
	
	IF test2=false THEN
	BEGIN
		test:=false;
	END;
	
		TestCaseLigne:=test;

END;
//


	//TOut les fonctions test
//BUT:Test les cases suivante dans la direction y pour chaque taille d'un bateau
//ENTREE:1 tableau type tabat, 1 tableay type tabcell,5 entier, 2 BOOLEAN
//SORTIE:1 BOOLEAN
FUNCTION TestCaseColonne(Bateau:tabat;poscell:tabcell;x,y,i:INTEGER):BOOLEAN;
VAR
	j:INTEGER;
	test,test2:BOOLEAN;
BEGIN

	test:=false;	
	FOR j:=1 TO Bateau[i].taille DO
	BEGIN
		IF (Bateau[j].n.colonne<>poscell[(y+(j-1))].colonne) AND (Bateau[j].n.ligne<>poscell[x].ligne) THEN
		BEGIN
			test:=true;	
		END;
		
		IF test=false THEN
		BEGIN
			test2:=false;
		END;
	END;
	
	IF test2=false THEN
	BEGIN
		test:=false;
	END;

	TestCaseColonne:=test;

END;
//


//BUT:Test pour que les bateaux de se superpose pas
//ENTREE:1 tableau type tabat,1 tableau type TabFlotte, 4 entier, 1 booleen
//SORTIE:1 BOOLEAN
FUNCTION TestCase(Bateau:tabat; enssemble:TabFlotte):BOOLEAN;
VAR
	i,j,l,k:INTEGER;
	test:BOOLEAN;
BEGIN
	test:=true;
	
	FOR i:=1 TO BATMAX DO
	BEGIN
		FOR j:=1 TO BATMAX DO
		BEGIN
			FOR k:=1 TO Bateau[i].taille DO
			BEGIN
				FOR l:=1 TO Bateau[i].taille DO
				BEGIN
					IF (enssemble[i,k].n1.n.ligne=enssemble[j,l].n1.n.ligne) AND (enssemble[i,k].n1.n.colonne=enssemble[j,l].n1.n.colonne) AND (j<>i) THEN
					BEGIN
						test:=false;
					END;
				END;
			END;
		END;
	END;
	TestCase:=test;
END;
//
//BUT:converti les chaine (caractere) en entier (Ex:'10'>10)
//ENTREE:1 STRING
//SORTIE:1 entier
FUNCTION one1(car:STRING):INTEGER;
BEGIN
		IF length(car)=1 THEN
		BEGIN
			IF(ord(car[1])>=48) AND (ord(car[1])<=57) THEN
			BEGIN
				one1:=ord(car[1])-48
			END
				ELSE
					BEGIN
					one1:=0;
					END;
		END
		ELSE
			IF length(car)=2 THEN
			BEGIN
				
				IF (ord(car[1])=49) AND (ord(car[2])=48)THEN
				BEGIN
					one1:=10
				END
					ELSE
					BEGIN
						one1:=0;
					END;
			END;
			
			
END;
//


//BUT:convertir les caractere en entier
//ENTREE:1 caractere
//SORTIE:1 entier

FUNCTION a1(car:CHAR):INTEGER;
BEGIN
	IF(ord(car)>=97) AND (ord(car)<97+MAX) THEN
	BEGIN	
		a1:=ord(car)-96
	END
		ELSE
			a1:=11;
END;
//

//BUT:Test Si les coord entrer existe
//ENTREE:1 tableau type TabFlotte, 1 tableau type tabat, 1 tableau type tabcell, 3 entier
//SORTIE:1 BOOLEAN
FUNCTION trouver(enssemble:TabFlotte;Bateau:tabat;poscell:tabcell;x,y:INTEGER;VAR nbr:INTEGER):BOOLEAN;
VAR
	i,j:INTEGER;
	test:BOOLEAN;
BEGIN
	test:=false;
	FOR i:=1 TO BATMAX DO
	BEGIN
		FOR j:=1 TO Bateau[i].taille DO
		BEGIN
			IF (enssemble[i,j].n1.n.colonne=poscell[y].colonne) AND (enssemble[i,j].n1.n.ligne=poscell[x].ligne) THEN
			BEGIN
				test:=true;
				nbr:=i;//Si la position entree = a la position du bateau
			END;
		END;
	END;
	trouver:=test;
END;
//


//BUT:Test si TOut les bateau on coule
//ENTREE:1 tableau type T
//SORTIE:1 BOOLEAN
FUNCTION ENDal(Nb:Tab):BOOLEAN;
VAR
	i,cpt:INTEGER;
	test:BOOLEAN;
BEGIN
	test:=false;
	cpt:=0;
	FOR i:=1 TO BATMAX DO
	BEGIN
		IF Nb[i]<1 THEN
		BEGIN
			cpt:=cpt+1;
			IF cpt=BATMAX THEN
			BEGIN
				test:=true;
			END;
		END;
	END;
	
	ENDal:=test;

END;
//
	//END test


	//TOut les PROCEDURE de creation
//BUT:Affecte les valeur x y a Pos
//ENTREE:1 tableau type poscell, 2 entier
//SORTIE:Tableau N valeur
PROCEDURE CreateCellule(VAR poscell:tabcell);
VAR
	cpt,i:INTEGER;
BEGIN	
	
	cpt:=7;
	FOR i:=1 TO MAX DO	//Valeur des cases y
	BEGIN
		poscell[i].ligne:=cpt;
		cpt:=cpt+4;
	END;

	cpt:=8;
	FOR i:=1 TO MAX DO	//Valeur des cases x
	BEGIN
		poscell[i].colonne:=cpt;
		cpt:=cpt+3;
	END;


END;
//


//BUT:Affecte les valeur des cellules a bateau
//ENTREE:1 tableau type tabcell, 1 tableau type tabat, 4 entier, 1 BOOLEAN
//SORTIE:1 tableau N cellule
PROCEDURE CreateNavire (poscell:tabcell;VAR Bateau:tabat;i:INTEGER);
VAR
	j,x,y,randomdir:INTEGER;
	test:BOOLEAN;
BEGIN

	REPEAT
	BEGIN
	RanDOmize;
	
	
		randomdir:=Random(2)+1;//Pour choisir le positionnement au hasard
	
		case randomdir of
			1:BEGIN		//Positionnement bateau vertical
	
					REPEAT
					BEGIN
						x:=Random(MAX)+1;//positionnement au hasard
						y:=Random(MAX)+1;
					END;
					UNTIL (y<=MAX-Bateau[i].taille);
					
					test:=TestCaseColonne(Bateau,poscell,x,y,i);	//test si les cases sont vide pour le bateau
					IF test=true THEN
					BEGIN
						
						FOR j:=1 TO Bateau[i].taille DO
						BEGIN
							Bateau[j].n.colonne:=poscell[(y+j)-1].colonne;
							Bateau[j].n.ligne:=poscell[x].ligne;
						END;
					END;
					
				END;
			
			2:BEGIN//Positionnement horizontal
			
					REPEAT
					BEGIN
						x:=Random(MAX)+1;//positionnement au hasard
						y:=Random(MAX)+1;
					END;
					UNTIL (x<=MAX-Bateau[i].taille);
					
					test:=TestCaseLigne(Bateau,poscell,x,y,i);	//test si les cases sont vide pour le bateau
					IF test=true THEN
					BEGIN
						
						FOR j:=1 TO Bateau[i].taille DO
						BEGIN
							Bateau[j].n.colonne:=poscell[y].colonne;
							Bateau[j].n.ligne:=poscell[(x+j)-1].ligne;
						END;
					END;
				
				END;
		END;

	END;
	UNTIL (test=true);

END;
//


//BUT:deENDi la taille d'un bateau
//ENTREE:1 tableau type tabat, un tableau typea T, 2 entier
//SORTIE:un tableau type T avec N entier
PROCEDURE TailleBateau(VAR Bateau:tabat;VAR tailleB:Tab);
VAR
	i,nbr:INTEGER;
BEGIN
	
	Randomize;
	
	FOR i:=1 TO BATMAX DO
	BEGIN
		REPEAT
			nbr:=Random(TMAX)+1;
		UNTIL nbr>1;
		
		Bateau[i].taille:=nbr;
		tailleB[i]:=Bateau[i].taille;
	END;

END;
//

//BUT:Affecte les valeurs des bateaux a la flotte
//ENTREE:1 tableau type tabat, 1 tableau type tabcell, 1 tableau type enssemble,2 entier, 1 BOOLEAN
//SORTIE:Tableau type TabFlotte avec N valeur entier
PROCEDURE CreateFlotte (Bateau:tabat; poscell:tabcell; VAR enssemble:TabFlotte);
VAR
	i,j:INTEGER;
	test:BOOLEAN;
BEGIN

	REPEAT
	BEGIN
		IniTabFlotte(Bateau,enssemble);
		
		FOR i:=1 TO BATMAX DO
		BEGIN

			CreateNavire(poscell,Bateau,i);
			

			FOR j:=1 TO Bateau[i].taille DO
			BEGIN	
					enssemble[i,j].n1.n.ligne:=Bateau[j].n.ligne;
					enssemble[i,j].n1.n.colonne:=Bateau[j].n.colonne;
			END;

		END;

		test:=TestCase(Bateau,enssemble);
		
	END;
	UNTIL (test=true);

END;
//
	//END creation
	
	//BEGIN programme principal
VAR
	
	poscell,celltouche:tabcell;
	bateau:tabat;
	Nom:TabNom;
	tailleB:Tab;
	enssemble:TabFlotte;
	x1,y1,i,k,j,nbr:INTEGER;
	y:CHAR;
	x,pseuDO:STRING;
	test:BOOLEAN;
	
	
BEGIN
	clrscr;
	
	Initabcell(poscell,celltouche);// Initialise des cellules

	AfficheMap();	//affiche le terrain
	
	CreateCellule(poscell);	//créer les cellules

	TailleBateau(Bateau,tailleB);	//deENDi le nombre de cellule des bateaux
	
	CreateFlotte(Bateau,poscell,enssemble);	//creer la flotte de bateaux
	
	
	//Affiche la flotte pour   la tester
	 FOR j:=1 TO BATMAX DO
	 BEGIN
		 FOR k:=1 TO Bateau[j].taille DO
		 BEGIN
		
		 (enssemble[j,k].n1.n.ligne,enssemble[j,k].n1.n.colonne);
		 WRITE(j);
		
		 END;
	 END;
	
	
 //AfficherFlotte(Bateau,,tailleB);
	
	REPEAT//boucle fin du jeu
	BEGIN

			REPEAT//boucle coordonne x
			BEGIN
				
				
				WRITE('Coordonne x ? 1-10');
			
				READLN(x);
				
				IF (x1=0) THEN
				BEGIN
					FOR i:=x TO x+10 DO
					
				END;
			END;
			UNTIL (x1<>0) AND (x<>'');;
			
			clrtxt2;
			
			REPEAT//boucle coordonne y
			BEGIN
				
				WRITE('Coordonne y ? a-j');
				
				READLN(y);
				y1:=a1(y);
				IF (y1=11) THEN
				
			END;
			UNTIL (y1<>11);
			

		//si jamais les valeurs correspondent
		test:=trouver(enssemble,Bateau,poscell,x1,y1,nbr);
		
		IF test=true THEN
		BEGIN
			
			//si jamais les cellules  touche sont differentes de la cellule donne
			IF (celltouche[nbr].ligne<>poscell[x1].ligne) OR (celltouche[nbr].colonne<>poscell[y1].colonne) THEN
			BEGIN
				
				IF (tailleB[nbr]>0) THEN
				BEGIN
				celltouche[nbr].ligne:=poscell[x1].ligne;
				celltouche[nbr].colonne:=poscell[y1].colonne;
			
				(poscell[x1].ligne,poscell[y1].colonne);
				WRITE('X');
				
				WRITE(Nom[nbr],' toucher !');
				tailleB[nbr]:=tailleB[nbr]-1;
				END;
				
				IF tailleB[nbr]<=0 THEN//si bateau detruit
				BEGIN
					WRITE(' navire couler !!!!');
					FOR i:=1 TO Bateau[nbr].taille DO
					BEGIN
						(enssemble[nbr,i].n1.n.ligne,enssemble[nbr,i].n1.n.colonne);
						WRITE('C');
					END;
					tailleB[nbr]:=-1;
				END;
			END
		END
		ELSE
		BEGIN
			(poscell[x1].ligne,poscell[y1].colonne);
			WRITE('0');
		END;
		
		clrtxt;
  //AfficherFlotte(Bateau,tailleB);
			
		test:=ENDal(tailleB);// test si TOut les bateaus sont detruits
	END;
	UNTIL test=true;//fin du jeu

	
	clrtxt2;
	
	
	WRITE('FIN');

	
	READLN;
END.
