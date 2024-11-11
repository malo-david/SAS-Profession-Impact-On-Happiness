/* IMPORTATION ET COPIE DES DONNÉES */

PROC IMPORT DATAFILE = "W:\Bureau\sas\mémoire\ESS6e02_5.csv"
out = ess
dbms = CSV;
RUN;

LIBNAME don "W:\Bureau\sas\mémoire";
DATA don.ess06;
SET ess;
RUN;

/* Copie des données concernant la France */
DATA france;
SET ess;
WHERE cntry="FR";
RUN;

/* statistiques générales à propos de happy */

PROC UNIVARIATE DATA = france;
VAR happy;
RUN;

/* ANALYSE PAR MÉTIERS */


/* On regroupe les métiers de isco08 en plusieurs classes */
DATA france;
SET france;
LENGTH metier $ 100;
IF isco08 >= 0 AND isco08 <= 999 THEN metier = "Armee";
ELSE IF isco08 >= 1000 AND isco08 <= 1999 THEN metier = "Cadres et dirigeants";
ELSE IF isco08 >= 2000 AND isco08 <= 2199 THEN metier = "Ingenieurs";
ELSE IF isco08 >= 2200 AND isco08 <= 2299 THEN metier = "Medecins";
ELSE IF isco08 >= 2300 AND isco08 <= 2399 THEN metier = "Enseignants";
ELSE IF isco08 >= 2400 AND isco08 <= 2499 THEN metier = "Finances et marketing";
ELSE IF isco08 >= 2500 AND isco08 <= 2599 THEN metier = "Ingenieurs informatique";
ELSE IF isco08 >= 2600 AND isco08 <= 2619 THEN metier = "Professions du droit";
ELSE IF isco08 >= 2620 AND isco08 <= 2699 THEN metier = "Arts et littérature";
ELSE IF isco08 >= 3000 AND isco08 <= 3215 THEN metier = "Techniciens";
ELSE IF isco08 >= 3220 AND isco08 <= 3299 THEN metier = "Infirmiers";
ELSE IF isco08 >= 3300 AND isco08 <= 3399 THEN metier = "Regulation";
ELSE IF isco08 >= 3400 AND isco08 <= 3499 THEN metier = "Culture";
ELSE IF isco08 >= 3500 AND isco08 <= 3999 THEN metier = "Techniciens de la communication";
ELSE IF isco08 >= 4000 AND isco08 <= 4999 THEN metier = "Administration";
ELSE IF isco08 >= 5000 AND isco08 <= 5999 THEN metier = "Services particuliers";
ELSE IF isco08 >= 6000 AND isco08 <= 6999 THEN metier = "Agriculteurs";
ELSE IF isco08 >= 7000 AND isco08 <= 7999 THEN metier = "Artisans";
ELSE IF isco08 >= 8000 AND isco08 <= 8999 THEN metier = "Conducteurs et chauffeurs";
ELSE IF isco08 >= 9000 AND isco08 <= 9999 THEN metier = "Taches menageres";
ELSE metier = "Autre";
RUN;

TITLE "Nombre d'individus par métiers";
PROC SGPLOT DATA=france;
VBAR metier / CATEGORYORDER=RESPDESC;
RUN;

/* Calcul de la moyenne par catégorie */
PROC MEANS DATA=france MEAN;
CLASS metier;
VAR happy;
OUTPUT OUT=moyennes MEAN=moyenneHappy;
RUN;

/* Définition du graphique en bâtons avec la procédure VBAR */
TITLE "Bonheur moyen en fonction du métier";
PROC SGPLOT DATA=moyennes;
VBAR Metier / RESPONSE=moyenneHappy CATEGORYORDER=RESPDESC;
RUN;


/* ANALYSE PAR POSITION ET ENVIRONNEMENT */


/*définition de la variable posandenv*/

DATA france;
SET france;
LENGTH posandenv $ 3;
posandenv = "0" ;
IF isco08 >= 0 AND isco08 <=310 THEN posandenv = "6"; 
ELSE IF isco08 >=1000 AND isco08<=1439 THEN posandenv = "1";
ELSE IF isco08 >= 2111 AND isco08 <= 2112 THEN posandenv = "1" ; 
ELSE IF isco08 = 2113 THEN posandenv = "2";
ELSE IF isco08 = 2114 THEN posandenv = "4";
ELSE IF isco08 = 2120 THEN posandenv = "1";
ELSE IF isco08 >= 2130 AND isco08 <= 2133 THEN posandenv = "4" ;
ELSE IF isco08 > 2140 AND isco08 <= 2149 THEN posandenv = "5";
ELSE IF isco08 > 2150 AND isco08 <= 2153 THEN posandenv = "1" ;
ELSE IF isco08 = 2161 THEN posandenv = "1";
ELSE IF isco08 = 2162 THEN posandenv = "3";
ELSE IF isco08 = 2163 THEN posandenv = "1";
ELSE IF isco08 = 2164 THEN posandenv = "1";
ELSE IF isco08 = 2165 THEN posandenv = "3";
ELSE IF isco08 = 2166 THEN posandenv = "1";
ELSE IF isco08 >= 2210 AND isco08 <= 2212 THEN posandenv = "1";
ELSE IF isco08 >= 2220 AND isco08 <= 2250 THEN posandenv = "2";
ELSE IF isco08 >= 2261 AND isco08 <= 2264 THEN posandenv = "2";
ELSE IF isco08 >= 2265 AND isco08 <= 2269 THEN posandenv = "1";
ELSE IF isco08 >= 2300 AND isco08 <= 2359 THEN posandenv = "2";
ELSE IF isco08 = 2411 THEN posandenv = "1";
ELSE IF isco08 = 2412 THEN posandenv = "2";
ELSE IF isco08 = 2113 THEN posandenv = "1";
ELSE IF isco08 = 2421 THEN posandenv = "1";
ELSE IF isco08 = 2422 THEN posandenv = "1";
ELSE IF isco08 = 2423 THEN posandenv = "2";
ELSE IF isco08 = 2424 THEN posandenv = "2";
ELSE IF isco08 = 2431 THEN posandenv = "1";
ELSE IF isco08 >= 2432 AND isco08 <= 2434 THEN posandenv = "2";
ELSE IF isco08 >= 2500 AND isco08 <= 2529 THEN posandenv = "1";
ELSE IF isco08 >= 2610 AND isco08 <= 2636 THEN posandenv = "1";
ELSE IF isco08 = 2641 THEN posandenv = "1";
ELSE IF isco08 = 2642 THEN posandenv = "5";
ELSE IF isco08 = 2643 THEN posandenv = "2";
ELSE IF isco08 = 2651 THEN posandenv = "1";
ELSE IF isco08 >= 2652 AND isco08 <= 2655 THEN posandenv = "2";
ELSE IF isco08 = 2656 THEN posandenv = "1";
ELSE IF isco08 = 2659 THEN posandenv = "2";
ELSE IF isco08 = 3111 THEN posandenv = "2";
ELSE IF isco08 >= 3112 AND isco08 <= 3113 THEN posandenv = "4";
ELSE IF isco08 >= 3114 AND isco08 <= 3116 THEN posandenv = "2";
ELSE IF isco08 = 3117 THEN posandenv = "4";
ELSE IF isco08 = 3118 THEN posandenv = "1";
ELSE IF isco08 = 3119 THEN posandenv = "2";
ELSE IF isco08 = 3121 THEN posandenv = "4";
ELSE IF isco08 = 3122 THEN posandenv = "2";
ELSE IF isco08 = 3123 THEN posandenv = "4";
ELSE IF isco08 >= 3130 AND isco08 <= 3139 THEN posandenv = "2";
ELSE IF isco08 = 3141 THEN posandenv = "2";
ELSE IF isco08 >= 3142 AND isco08 <= 3143 THEN posandenv = "4";
ELSE IF isco08 >= 3150 AND isco08 <= 3155 THEN posandenv = "1";
ELSE IF isco08 >= 3210 AND isco08 <= 3240 THEN posandenv = "2";
ELSE IF isco08 = 3251 THEN posandenv = "2";
ELSE IF isco08 = 3252 THEN posandenv = "1";
ELSE IF isco08 >= 3253 AND isco08 <= 3256 THEN posandenv = "2";
ELSE IF isco08 >= 3257 AND isco08 <= 3258 THEN posandenv = "4";
ELSE IF isco08 = 3259 THEN posandenv = "2";
ELSE IF isco08 >= 3310 AND isco08 <= 3344 THEN posandenv = "1";
ELSE IF isco08 >= 3351 AND isco08 <= 3354 THEN posandenv = "1";
ELSE IF isco08 = 3355 THEN posandenv = "4";
ELSE IF isco08 = 3359 THEN posandenv = "1";
ELSE IF isco08 = 3411 THEN posandenv = "4";
ELSE IF isco08 >= 3412 AND isco08 <= 3413 THEN posandenv = "1";
ELSE IF isco08 >= 3420 AND isco08 <= 3423 THEN posandenv = "4";
ELSE IF isco08 = 3431 THEN posandenv = "4";
ELSE IF isco08 >= 3432 AND isco08<=3435 THEN posandenv = "2";
ELSE IF isco08 >= 3500 AND isco08<=3522 THEN posandenv = "1";
ELSE IF isco08 >= 4000 AND isco08<=4223 THEN posandenv = "1";
ELSE IF isco08 >= 4224 AND isco08<=4226 THEN posandenv = "2";
ELSE IF isco08 >= 4227 AND isco08<=4419 THEN posandenv = "1";
ELSE IF isco08 >= 5110 AND isco08<=5113 THEN posandenv = "6"; 
ELSE IF isco08 >= 5120 AND isco08<=5164 THEN posandenv = "2";
ELSE IF isco08 = 5165 THEN posandenv = "3";
ELSE IF isco08 = 5169 THEN posandenv = "2";
ELSE IF isco08 >= 5110 AND isco08<=5212 THEN posandenv = "4";
ELSE IF isco08 >= 5220 AND isco08<=5230 THEN posandenv = "2";
ELSE IF isco08 >= 5241 AND isco08<=5242 THEN posandenv = "2";
ELSE IF isco08 = 5243 THEN posandenv = "4";
ELSE IF isco08 >= 5244 AND isco08<=5249 THEN posandenv = "2";
ELSE IF isco08 >= 5310 AND isco08<=5329 THEN posandenv = "2";
ELSE IF isco08 >= 5400 AND isco08<=5419 THEN posandenv = "4";
ELSE IF isco08 >= 6000 AND isco08<= 6340 THEN posandenv = "4";
ELSE IF isco08 >= 7110 AND isco08<= 7119 THEN posandenv = "4";
ELSE IF isco08 >= 7120 AND isco08<= 7133 THEN posandenv = "2";
ELSE IF isco08 >= 7200 AND isco08<= 7323 THEN posandenv = "2";
ELSE IF isco08 >= 7400 AND isco08<= 7422 THEN posandenv = "4";
ELSE IF isco08 >= 7500 AND isco08<= 7536 THEN posandenv = "2";
ELSE IF isco08 >= 7541 AND isco08<= 7542 THEN posandenv = "4";
ELSE IF isco08 >= 7400 AND isco08<= 7422 THEN posandenv = "4";
ELSE IF isco08 = 7543 THEN posandenv = "2";
ELSE IF isco08 = 7544 THEN posandenv = "4";
ELSE IF isco08 = 7549 THEN posandenv = "2";
ELSE IF isco08 >= 8110 AND isco08<= 8114 THEN posandenv = "4";
ELSE IF isco08 >= 8120 AND isco08<= 8189 THEN posandenv = "2";
ELSE IF isco08 >= 8200 AND isco08<= 8219 THEN posandenv = "2";
ELSE IF isco08 >= 8310 AND isco08<= 8344 THEN posandenv = "3";
ELSE IF isco08 = 8350 THEN posandenv = "4";
ELSE IF isco08 >= 9110 AND isco08<= 9121 THEN posandenv = "2";
ELSE IF isco08 >= 9122 AND isco08<= 9123 THEN posandenv = "4";
ELSE IF isco08 = 9129 THEN posandenv = "2";
ELSE IF isco08 >= 9200 AND isco08<= 9216 THEN posandenv = "4";
ELSE IF isco08 >= 9310 AND isco08<= 9313 THEN posandenv = "4";
ELSE IF isco08 >= 9320 AND isco08<= 9329 THEN posandenv = "1";
ELSE IF isco08 >= 9331 AND isco08<= 9332 THEN posandenv = "3";
ELSE IF isco08 >= 9333 AND isco08<= 9334 THEN posandenv = "2";
ELSE IF isco08 >= 9410 AND isco08<= 9412 THEN posandenv = "2";
ELSE IF isco08 >= 9500 AND isco08<= 9520 THEN posandenv = "4";
ELSE IF isco08 >= 9610 AND isco08<= 9611 THEN posandenv = "4";
ELSE IF isco08 = 9612 THEN posandenv = "2";
ELSE IF isco08 >= 9613 AND isco08<= 9629 THEN posandenv = "4";
RUN;

/* définition d'un format pour la variable posandenv */

PROC FORMAT;
 VALUE $format_posandenv
 "0" = "pas d'information"
 "1" = "assis et en intérieur"
 "2" = "debout et en intérieur"
 "3" = "assis et en extérieur"
 "4" = "debout et en extérieur"
 "5" = "alternativement assis et debout, en intérieur"
 "6" = "alternativement assis et debout, en extérieur"
;
RUN;

TITLE "Nombre d'individus selon que leur profession s'exerce assis/debout, en intérieur/extérieur";
PROC SGPLOT DATA=france;
xaxis label="professions où l'on travaille...";
VBAR posandenv / CATEGORYORDER=RESPDESC;
FORMAT posandenv $format_posandenv.;
RUN;

/* Calcul de la moyenne par catégorie */
PROC MEANS DATA=france MEAN;
CLASS posandenv;
VAR happy;
OUTPUT OUT=moyennes2 MEAN=moyenneHappy2;
RUN;

/* Définition du graphique en bâtons avec la procédure VBAR */
TITLE "Bonheur moyen en fonction de la position et de l'environnement de travail (avec seulement les quatres catégories principales)";
PROC SGPLOT DATA=moyennes2;
xaxis label="professions où l'on travaille...";
VBAR posandenv / RESPONSE=moyenneHappy2 CATEGORYORDER=RESPDESC;
WHERE posandenv <> "0" AND posandenv<>"5" AND posandenv <> "6";
FORMAT posandenv $format_posandenv.;
RUN;


/* ANALYSE PAR GROUPE SOCIOPROFESSIONEL */


/* définition d'une variable pcs */

DATA france;
SET france;
LENGTH pcs $ 50;
IF isco08 >= "0" AND isco08 <= 999 THEN pcs = "5";
ELSE IF isco08 >= 1000 AND isco08 <= 1999 THEN pcs = "3";
ELSE IF isco08 >= 2000 AND isco08 <= 2199 THEN pcs = "3";
ELSE IF isco08 >= 2200 AND isco08 <= 2299 THEN pcs = "3";
ELSE IF isco08 >= 2300 AND isco08 <= 2399 THEN pcs = "3";
ELSE IF isco08 >= 2400 AND isco08 <= 2499 THEN pcs = "3";
ELSE IF isco08 >= 2500 AND isco08 <= 2599 THEN pcs = "3";
ELSE IF isco08 >= 2600 AND isco08 <= 2619 THEN pcs = "3";
ELSE IF isco08 >= 2620 AND isco08 <= 2699 THEN pcs = "3";
ELSE IF isco08 >= 3000 AND isco08 <= 3215 THEN pcs = "4";
ELSE IF isco08 >= 3220 AND isco08 <= 3299 THEN pcs = "4";
ELSE IF isco08 >= 3300 AND isco08 <= 3399 THEN pcs = "4";
ELSE IF isco08 >= 3400 AND isco08 <= 3499 THEN pcs = "4";
ELSE IF isco08 >= 3500 AND isco08 <= 3999 THEN pcs = "4";
ELSE IF isco08 >= 4000 AND isco08 <= 4999 THEN pcs = "5";
ELSE IF isco08 >= 5000 AND isco08 <= 5999 THEN pcs = "5";
ELSE IF isco08 >= 6000 AND isco08 <= 6999 THEN pcs = "1";
ELSE IF isco08 >= 7000 AND isco08 <= 7999 THEN pcs = "2";
ELSE IF isco08 >= 8000 AND isco08 <= 8999 THEN pcs = "6";
ELSE IF isco08 >= 9000 AND isco08 <= 9999 THEN pcs = "6";
ELSE metier = "Autre";
RUN;

/* définition d'un format pour la variable pcs */

PROC FORMAT;
 VALUE $format_pcs
 "0" = "pas d'information sur le groupe socioprofessionel"
 "1" = "Agriculteurs exploitants"
 "2" = "Artisans, commerçants et chefs d’entreprise"
 "3" = "Cadres et professions intellectuelles supérieures"
 "4" = "Professions Intermédiaires"
 "5" = "Employés"
 "6" = "Ouvriers"
;
RUN;

TITLE "Nombre d'individus par groupes socioprofessionels";
PROC SGPLOT DATA=france;
VBAR pcs / CATEGORYORDER=RESPDESC;
FORMAT pcs $format_pcs.;
RUN;

/* Calcul de la moyenne par catégorie */
PROC MEANS DATA=france MEAN;
CLASS pcs;
VAR happy;
OUTPUT OUT=moyennes3 MEAN=moyenneHappy3;
RUN;

/* Définition du graphique en bâtons avec la procédure VBAR */
TITLE "Bonheur moyen en fonction du groupe socioprofessionel";
PROC SGPLOT DATA=moyennes3;
VBAR pcs / RESPONSE=moyenneHappy3 CATEGORYORDER=RESPDESC;
FORMAT pcs $format_pcs.;
RUN;


/* ANALYSE PAR NOMBRE DE LETTRES */


/* On définit une nouvelle variable qui compte le nombre de caractères de l'intitulé du métier*/
DATA france;
SET france;
nb_car_metier = input(length(metier));
RUN;

TITLE "Nombre d'individus selon le nombre de caractères de l'intitulé de leur métier";
PROC SGPLOT DATA=france;
VBAR nb_car_metier / CATEGORYORDER=RESPDESC;
RUN;

/* Calcul de la moyenne par catégorie */
PROC MEANS DATA=france MEAN;
CLASS nb_car_metier;
VAR happy;
OUTPUT OUT=moyennes4 MEAN=moyenneHappy4;
RUN;

/* Définition du graphique en bâtons avec la procédure VBAR */
TITLE "Bonheur moyen en fonction du nombre de caractères dans l'intitulé du métier";
PROC SGPLOT DATA=moyennes4;
VBAR nb_car_metier / RESPONSE=moyenneHappy4 CATEGORYORDER=RESPDESC;
RUN;


/* ANALYSE CORRELATION */

data france;
   set france;  
   longueur_metier = length(metier);
run;

PROC MEANS DATA=france MEAN;
CLASS longueur_metier;
VAR happy;
OUTPUT OUT=france MEAN=moyenneHappy5;
RUN;

TITLE "Corrélation de Pearson entre bonheur moyen et nombre de caractères dans l'intitulé du métier";
PROC CORR DATA=france;
   VAR moyenneHappy5 longueur_metier;
run;


/* CORRELATION MAIS AVEC PROFESSION ET NON METIER */

DATA france;
SET france;
LENGTH intitu_prof $ 150;
IF isco08 = 0 THEN intitu_prof = "Armed forces occupations";
ELSE IF isco08 = 100 THEN intitu_prof = "Commissioned armed forces officers";
ELSE IF isco08 = 110 THEN intitu_prof = "Commissioned armed forces officers";
ELSE IF isco08 = 200 THEN intitu_prof = "Non-commissioned armed forces officers";
ELSE IF isco08 = 210 THEN intitu_prof = "Non-commissioned armed forces officers";
ELSE IF isco08 = 300 THEN intitu_prof = "Armed forces occupations, other ranks";
ELSE IF isco08 = 310 THEN intitu_prof = "Armed forces occupations, other ranks";
ELSE IF isco08 = 1000 THEN intitu_prof = "Managers";
ELSE IF isco08 = 1100 THEN intitu_prof = "Chief executives, senior officials and legislators";
ELSE IF isco08 = 1110 THEN intitu_prof = "Legislators and senior officials";
ELSE IF isco08 = 1111 THEN intitu_prof = "Legislators";
ELSE IF isco08 = 1112 THEN intitu_prof = "Senior government officials";
ELSE IF isco08 = 1113 THEN intitu_prof = "Traditional chiefs and heads of village";
ELSE IF isco08 = 1114 THEN intitu_prof = "Senior officials of special-interest organizations";
ELSE IF isco08 = 1120 THEN intitu_prof = "Managing directors and chief executives";
ELSE IF isco08 = 1200 THEN intitu_prof = "Administrative and commercial managers";
ELSE IF isco08 = 1210 THEN intitu_prof = "Business services and administration managers";
ELSE IF isco08 = 1211 THEN intitu_prof = "Finance managers";
ELSE IF isco08 = 1212 THEN intitu_prof = "Human resource managers";
ELSE IF isco08 = 1213 THEN intitu_prof = "Policy and planning managers";
ELSE IF isco08 = 1219 THEN intitu_prof = "Business services and administration managers not elsewhere classified";
ELSE IF isco08 = 1220 THEN intitu_prof = "Sales, marketing and development managers";
ELSE IF isco08 = 1221 THEN intitu_prof = "Sales and marketing managers";
ELSE IF isco08 = 1222 THEN intitu_prof = "Advertising and public relations managers";
ELSE IF isco08 = 1223 THEN intitu_prof = "Research and development managers";
ELSE IF isco08 = 1300 THEN intitu_prof = "Production and specialised services managers";
ELSE IF isco08 = 1310 THEN intitu_prof = "Production managers in agriculture, forestry and fisheries";
ELSE IF isco08 = 1311 THEN intitu_prof = "Agricultural and forestry production managers";
ELSE IF isco08 = 1312 THEN intitu_prof = "Aquaculture and fisheries production managers";
ELSE IF isco08 = 1320 THEN intitu_prof = "Manufacturing, mining, construction, and distribution managers";
ELSE IF isco08 = 1321 THEN intitu_prof = "Manufacturing managers";
ELSE IF isco08 = 1322 THEN intitu_prof = "Mining managers";
ELSE IF isco08 = 1323 THEN intitu_prof = "Construction managers";
ELSE IF isco08 = 1324 THEN intitu_prof = "Supply, distribution and related managers";
ELSE IF isco08 = 1330 THEN intitu_prof = "Information and communications technology service managers";
ELSE IF isco08 = 1340 THEN intitu_prof = "Professional services managers";
ELSE IF isco08 = 1341 THEN intitu_prof = "Child care services managers";
ELSE IF isco08 = 1342 THEN intitu_prof = "Health services managers";
ELSE IF isco08 = 1343 THEN intitu_prof = "Aged care services managers";
ELSE IF isco08 = 1344 THEN intitu_prof = "Social welfare managers";
ELSE IF isco08 = 1345 THEN intitu_prof = "Education managers";
ELSE IF isco08 = 1346 THEN intitu_prof = "Financial and insurance services branch managers";
ELSE IF isco08 = 1349 THEN intitu_prof = "Professional services managers not elsewhere classified";
ELSE IF isco08 = 1400 THEN intitu_prof = "Hospitality, retail and other services managers";
ELSE IF isco08 = 1410 THEN intitu_prof = "Hotel and restaurant managers";
ELSE IF isco08 = 1411 THEN intitu_prof = "Hotel managers";
ELSE IF isco08 = 1412 THEN intitu_prof = "Restaurant managers";
ELSE IF isco08 = 1420 THEN intitu_prof = "Retail and wholesale trade managers";
ELSE IF isco08 = 1430 THEN intitu_prof = "Other services managers";
ELSE IF isco08 = 1431 THEN intitu_prof = "Sports, recreation and cultural centre managers";
ELSE IF isco08 = 1439 THEN intitu_prof = "Services managers not elsewhere classified";
ELSE IF isco08 = 2000 THEN intitu_prof = "Professionals";
ELSE IF isco08 = 2100 THEN intitu_prof = "Science and engineering professionals";
ELSE IF isco08 = 2110 THEN intitu_prof = "Physical and earth science professionals";
ELSE IF isco08 = 2111 THEN intitu_prof = "Physicists and astronomers";
ELSE IF isco08 = 2112 THEN intitu_prof = "Meteorologists";
ELSE IF isco08 = 2113 THEN intitu_prof = "Chemists";
ELSE IF isco08 = 2114 THEN intitu_prof = "Geologists and geophysicists";
ELSE IF isco08 = 2120 THEN intitu_prof = "Mathematicians, actuaries and statisticians";
ELSE IF isco08 = 2130 THEN intitu_prof = "Life science professionals";
ELSE IF isco08 = 2131 THEN intitu_prof = "Biologists, botanists, zoologists and related professionals";
ELSE IF isco08 = 2132 THEN intitu_prof = "Farming, forestry and fisheries advisers";
ELSE IF isco08 = 2133 THEN intitu_prof = "Environmental protection professionals";
ELSE IF isco08 = 2140 THEN intitu_prof = "Engineering professionals (excluding electrotechnology)";
ELSE IF isco08 = 2141 THEN intitu_prof = "Industrial and production engineers";
ELSE IF isco08 = 2142 THEN intitu_prof = "Civil engineers";
ELSE IF isco08 = 2143 THEN intitu_prof = "Environmental engineers";
ELSE IF isco08 = 2144 THEN intitu_prof = "Mechanical engineers";
ELSE IF isco08 = 2145 THEN intitu_prof = "Chemical engineers";
ELSE IF isco08 = 2146 THEN intitu_prof = "Mining engineers, metallurgists and related professionals";
ELSE IF isco08 = 2149 THEN intitu_prof = "Engineering professionals not elsewhere classified";
ELSE IF isco08 = 2150 THEN intitu_prof = "Electrotechnology engineers";
ELSE IF isco08 = 2151 THEN intitu_prof = "Electrical engineers";
ELSE IF isco08 = 2152 THEN intitu_prof = "Electronics engineers";
ELSE IF isco08 = 2153 THEN intitu_prof = "Telecommunications engineers";
ELSE IF isco08 = 2160 THEN intitu_prof = "Architects, planners, surveyors and designers";
ELSE IF isco08 = 2161 THEN intitu_prof = "Building architects";
ELSE IF isco08 = 2162 THEN intitu_prof = "Landscape architects";
ELSE IF isco08 = 2163 THEN intitu_prof = "Product and garment designers";
ELSE IF isco08 = 2164 THEN intitu_prof = "Town and traffic planners";
ELSE IF isco08 = 2165 THEN intitu_prof = "Cartographers and surveyors";
ELSE IF isco08 = 2166 THEN intitu_prof = "Graphic and multimedia designers";
ELSE IF isco08 = 2200 THEN intitu_prof = "Health professionals";
ELSE IF isco08 = 2210 THEN intitu_prof = "Medical doctors";
ELSE IF isco08 = 2211 THEN intitu_prof = "Generalist medical practitioners";
ELSE IF isco08 = 2212 THEN intitu_prof = "Specialist medical practitioners";
ELSE IF isco08 = 2220 THEN intitu_prof = "Nursing and midwifery professionals";
ELSE IF isco08 = 2221 THEN intitu_prof = "Nursing professionals";
ELSE IF isco08 = 2222 THEN intitu_prof = "Midwifery professionals";
ELSE IF isco08 = 2230 THEN intitu_prof = "Traditional and complementary medicine professionals";
ELSE IF isco08 = 2240 THEN intitu_prof = "Paramedical practitioners";
ELSE IF isco08 = 2250 THEN intitu_prof = "Veterinarians";
ELSE IF isco08 = 2260 THEN intitu_prof = "Other health professionals";
ELSE IF isco08 = 2261 THEN intitu_prof = "Dentists";
ELSE IF isco08 = 2262 THEN intitu_prof = "Pharmacists";
ELSE IF isco08 = 2263 THEN intitu_prof = "Environmental and occupational health and hygiene professionals";
ELSE IF isco08 = 2264 THEN intitu_prof = "Physiotherapists";
ELSE IF isco08 = 2265 THEN intitu_prof = "Dieticians and nutritionists";
ELSE IF isco08 = 2266 THEN intitu_prof = "Audiologists and speech therapists";
ELSE IF isco08 = 2267 THEN intitu_prof = "Optometrists and ophthalmic opticians";
ELSE IF isco08 = 2269 THEN intitu_prof = "Health professionals not elsewhere classified";
ELSE IF isco08 = 2300 THEN intitu_prof = "Teaching professionals";
ELSE IF isco08 = 2310 THEN intitu_prof = "University and higher education teachers";
ELSE IF isco08 = 2320 THEN intitu_prof = "Vocational education teachers";
ELSE IF isco08 = 2330 THEN intitu_prof = "Secondary education teachers";
ELSE IF isco08 = 2340 THEN intitu_prof = "Primary school and early childhood teachers";
ELSE IF isco08 = 2341 THEN intitu_prof = "Primary school teachers";
ELSE IF isco08 = 2342 THEN intitu_prof = "Early childhood educators";
ELSE IF isco08 = 2350 THEN intitu_prof = "Other teaching professionals";
ELSE IF isco08 = 2351 THEN intitu_prof = "Education methods specialists";
ELSE IF isco08 = 2352 THEN intitu_prof = "Special needs teachers";
ELSE IF isco08 = 2353 THEN intitu_prof = "Other language teachers";
ELSE IF isco08 = 2354 THEN intitu_prof = "Other music teachers";
ELSE IF isco08 = 2355 THEN intitu_prof = "Other arts teachers";
ELSE IF isco08 = 2356 THEN intitu_prof = "Information technology trainers";
ELSE IF isco08 = 2359 THEN intitu_prof = "Teaching professionals not elsewhere classified";
ELSE IF isco08 = 2400 THEN intitu_prof = "Business and administration professionals";
ELSE IF isco08 = 2410 THEN intitu_prof = "Finance professionals";
ELSE IF isco08 = 2411 THEN intitu_prof = "Accountants";
ELSE IF isco08 = 2412 THEN intitu_prof = "Financial and investment advisers";
ELSE IF isco08 = 2413 THEN intitu_prof = "Financial analysts";
ELSE IF isco08 = 2420 THEN intitu_prof = "Administration professionals";
ELSE IF isco08 = 2421 THEN intitu_prof = "Management and organization analysts";
ELSE IF isco08 = 2422 THEN intitu_prof = "Policy administration professionals";
ELSE IF isco08 = 2423 THEN intitu_prof = "Personnel and careers professionals";
ELSE IF isco08 = 2424 THEN intitu_prof = "Training and staff development professionals";
ELSE IF isco08 = 2430 THEN intitu_prof = "Sales, marketing and public relations professionals";
ELSE IF isco08 = 2431 THEN intitu_prof = "Advertising and marketing professionals";
ELSE IF isco08 = 2432 THEN intitu_prof = "Public relations professionals";
ELSE IF isco08 = 2433 THEN intitu_prof = "Technical and medical sales professionals (excluding ICT)";
ELSE IF isco08 = 2434 THEN intitu_prof = "Information and communications technology sales professionals";
ELSE IF isco08 = 2500 THEN intitu_prof = "Information and communications technology professionals";
ELSE IF isco08 = 2510 THEN intitu_prof = "Software and applications developers and analysts";
ELSE IF isco08 = 2511 THEN intitu_prof = "Systems analysts";
ELSE IF isco08 = 2512 THEN intitu_prof = "Software developers";
ELSE IF isco08 = 2513 THEN intitu_prof = "Web and multimedia developers";
ELSE IF isco08 = 2514 THEN intitu_prof = "Applications programmers";
ELSE IF isco08 = 2519 THEN intitu_prof = "Software and applications developers and analysts not elsewhere classified";
ELSE IF isco08 = 2520 THEN intitu_prof = "Database and network professionals";
ELSE IF isco08 = 2521 THEN intitu_prof = "Database designers and administrators";
ELSE IF isco08 = 2522 THEN intitu_prof = "Systems administrators";
ELSE IF isco08 = 2523 THEN intitu_prof = "Computer network professionals";
ELSE IF isco08 = 2529 THEN intitu_prof = "Database and network professionals not elsewhere classified";
ELSE IF isco08 = 2600 THEN intitu_prof = "Legal, social and cultural professionals";
ELSE IF isco08 = 2610 THEN intitu_prof = "Legal professionals";
ELSE IF isco08 = 2611 THEN intitu_prof = "Lawyers";
ELSE IF isco08 = 2612 THEN intitu_prof = "Judges";
ELSE IF isco08 = 2619 THEN intitu_prof = "Legal professionals not elsewhere classified";
ELSE IF isco08 = 2620 THEN intitu_prof = "Librarians, archivists and curators";
ELSE IF isco08 = 2621 THEN intitu_prof = "Archivists and curators";
ELSE IF isco08 = 2622 THEN intitu_prof = "Librarians and related information professionals";
ELSE IF isco08 = 2630 THEN intitu_prof = "Social and religious professionals";
ELSE IF isco08 = 2631 THEN intitu_prof = "Economists";
ELSE IF isco08 = 2632 THEN intitu_prof = "Sociologists, anthropologists and related professionals";
ELSE IF isco08 = 2633 THEN intitu_prof = "Philosophers, historians and political scientists";
ELSE IF isco08 = 2634 THEN intitu_prof = "Psychologists";
ELSE IF isco08 = 2635 THEN intitu_prof = "Social work and counselling professionals";
ELSE IF isco08 = 2636 THEN intitu_prof = "Religious professionals";
ELSE IF isco08 = 2640 THEN intitu_prof = "Authors, journalists and linguists";
ELSE IF isco08 = 2641 THEN intitu_prof = "Authors and related writers";
ELSE IF isco08 = 2642 THEN intitu_prof = "Journalists";
ELSE IF isco08 = 2643 THEN intitu_prof = "Translators, interpreters and other linguists";
ELSE IF isco08 = 2650 THEN intitu_prof = "Creative and performing artists";
ELSE IF isco08 = 2651 THEN intitu_prof = "Visual artists";
ELSE IF isco08 = 2652 THEN intitu_prof = "Musicians, singers and composers";
ELSE IF isco08 = 2653 THEN intitu_prof = "Dancers and choreographers";
ELSE IF isco08 = 2654 THEN intitu_prof = "Film, stage and related directors and producers";
ELSE IF isco08 = 2655 THEN intitu_prof = "Actors";
ELSE IF isco08 = 2656 THEN intitu_prof = "Announcers on radio, television and other media";
ELSE IF isco08 = 2659 THEN intitu_prof = "Creative and performing artists not elsewhere classified";
ELSE IF isco08 = 3000 THEN intitu_prof = "Technicians and associate professionals";
ELSE IF isco08 = 3100 THEN intitu_prof = "Science and engineering associate professionals";
ELSE IF isco08 = 3110 THEN intitu_prof = "Physical and engineering science technicians";
ELSE IF isco08 = 3111 THEN intitu_prof = "Chemical and physical science technicians";
ELSE IF isco08 = 3112 THEN intitu_prof = "Civil engineering technicians";
ELSE IF isco08 = 3113 THEN intitu_prof = "Electrical engineering technicians";
ELSE IF isco08 = 3114 THEN intitu_prof = "Electronics engineering technicians";
ELSE IF isco08 = 3115 THEN intitu_prof = "Mechanical engineering technicians";
ELSE IF isco08 = 3116 THEN intitu_prof = "Chemical engineering technicians";
ELSE IF isco08 = 3117 THEN intitu_prof = "Mining and metallurgical technicians";
ELSE IF isco08 = 3118 THEN intitu_prof = "Draughtspersons";
ELSE IF isco08 = 3119 THEN intitu_prof = "Physical and engineering science technicians not elsewhere classified";
ELSE IF isco08 = 3120 THEN intitu_prof = "Mining, manufacturing and construction supervisors";
ELSE IF isco08 = 3121 THEN intitu_prof = "Mining supervisors";
ELSE IF isco08 = 3122 THEN intitu_prof = "Manufacturing supervisors";
ELSE IF isco08 = 3123 THEN intitu_prof = "Construction supervisors";
ELSE IF isco08 = 3130 THEN intitu_prof = "Process control technicians";
ELSE IF isco08 = 3131 THEN intitu_prof = "Power production plant operators";
ELSE IF isco08 = 3132 THEN intitu_prof = "Incinerator and water treatment plant operators";
ELSE IF isco08 = 3133 THEN intitu_prof = "Chemical processing plant controllers";
ELSE IF isco08 = 3134 THEN intitu_prof = "Petroleum and natural gas refining plant operators";
ELSE IF isco08 = 3135 THEN intitu_prof = "Metal production process controllers";
ELSE IF isco08 = 3139 THEN intitu_prof = "Process control technicians not elsewhere classified";
ELSE IF isco08 = 3140 THEN intitu_prof = "Life science technicians and related associate professionals";
ELSE IF isco08 = 3141 THEN intitu_prof = "Life science technicians (excluding medical)";
ELSE IF isco08 = 3142 THEN intitu_prof = "Agricultural technicians";
ELSE IF isco08 = 3143 THEN intitu_prof = "Forestry technicians";
ELSE IF isco08 = 3150 THEN intitu_prof = "Ship and aircraft controllers and technicians";
ELSE IF isco08 = 3151 THEN intitu_prof = "Ships engineers";
ELSE IF isco08 = 3152 THEN intitu_prof = "Ships deck officers and pilots";
ELSE IF isco08 = 3153 THEN intitu_prof = "Aircraft pilots and related associate professionals";
ELSE IF isco08 = 3154 THEN intitu_prof = "Air traffic controllers";
ELSE IF isco08 = 3155 THEN intitu_prof = "Air traffic safety electronics technicians";
ELSE IF isco08 = 3200 THEN intitu_prof = "Health associate professionals";
ELSE IF isco08 = 3210 THEN intitu_prof = "Medical and pharmaceutical technicians";
ELSE IF isco08 = 3211 THEN intitu_prof = "Medical imaging and therapeutic equipment technicians";
ELSE IF isco08 = 3212 THEN intitu_prof = "Medical and pathology laboratory technicians";
ELSE IF isco08 = 3213 THEN intitu_prof = "Pharmaceutical technicians and assistants";
ELSE IF isco08 = 3214 THEN intitu_prof = "Medical and dental prosthetic technicians";
ELSE IF isco08 = 3220 THEN intitu_prof = "Nursing and midwifery associate professionals";
ELSE IF isco08 = 3221 THEN intitu_prof = "Nursing associate professionals";
ELSE IF isco08 = 3222 THEN intitu_prof = "Midwifery associate professionals";
ELSE IF isco08 = 3230 THEN intitu_prof = "Traditional and complementary medicine associate professionals";
ELSE IF isco08 = 3240 THEN intitu_prof = "Veterinary technicians and assistants";
ELSE IF isco08 = 3250 THEN intitu_prof = "Other health associate professionals";
ELSE IF isco08 = 3251 THEN intitu_prof = "Dental assistants and therapists";
ELSE IF isco08 = 3252 THEN intitu_prof = "Medical records and health information technicians";
ELSE IF isco08 = 3253 THEN intitu_prof = "Community health workers";
ELSE IF isco08 = 3254 THEN intitu_prof = "Dispensing opticians";
ELSE IF isco08 = 3255 THEN intitu_prof = "Physiotherapy technicians and assistants";
ELSE IF isco08 = 3256 THEN intitu_prof = "Medical assistants";
ELSE IF isco08 = 3257 THEN intitu_prof = "Environmental and occupational health inspectors and associates";
ELSE IF isco08 = 3258 THEN intitu_prof = "Ambulance workers";
ELSE IF isco08 = 3259 THEN intitu_prof = "Health associate professionals not elsewhere classified";
ELSE IF isco08 = 3300 THEN intitu_prof = "Business and administration associate professionals";
ELSE IF isco08 = 3310 THEN intitu_prof = "Financial and mathematical associate professionals";
ELSE IF isco08 = 3311 THEN intitu_prof = "Securities and finance dealers and brokers";
ELSE IF isco08 = 3312 THEN intitu_prof = "Credit and loans officers";
ELSE IF isco08 = 3313 THEN intitu_prof = "Accounting associate professionals";
ELSE IF isco08 = 3314 THEN intitu_prof = "Statistical, mathematical and related associate professionals";
ELSE IF isco08 = 3315 THEN intitu_prof = "Valuers and loss assessors";
ELSE IF isco08 = 3320 THEN intitu_prof = "Sales and purchasing agents and brokers";
ELSE IF isco08 = 3321 THEN intitu_prof = "Insurance representatives";
ELSE IF isco08 = 3322 THEN intitu_prof = "Commercial sales representatives";
ELSE IF isco08 = 3323 THEN intitu_prof = "Buyers";
ELSE IF isco08 = 3324 THEN intitu_prof = "Trade brokers";
ELSE IF isco08 = 3330 THEN intitu_prof = "Business services agents";
ELSE IF isco08 = 3331 THEN intitu_prof = "Clearing and forwarding agents";
ELSE IF isco08 = 3332 THEN intitu_prof = "Conference and event planners";
ELSE IF isco08 = 3333 THEN intitu_prof = "Employment agents and contractors";
ELSE IF isco08 = 3334 THEN intitu_prof = "Real estate agents and property managers";
ELSE IF isco08 = 3339 THEN intitu_prof = "Business services agents not elsewhere classified";
ELSE IF isco08 = 3340 THEN intitu_prof = "Administrative and specialised secretaries";
ELSE IF isco08 = 3341 THEN intitu_prof = "Office supervisors";
ELSE IF isco08 = 3342 THEN intitu_prof = "Legal secretaries";
ELSE IF isco08 = 3343 THEN intitu_prof = "Administrative and executive secretaries";
ELSE IF isco08 = 3344 THEN intitu_prof = "Medical secretaries";
ELSE IF isco08 = 3350 THEN intitu_prof = "Regulatory government associate professionals";
ELSE IF isco08 = 3351 THEN intitu_prof = "Customs and border inspectors";
ELSE IF isco08 = 3352 THEN intitu_prof = "Government tax and excise officials";
ELSE IF isco08 = 3353 THEN intitu_prof = "Government social benefits officials";
ELSE IF isco08 = 3354 THEN intitu_prof = "Government licensing officials";
ELSE IF isco08 = 3355 THEN intitu_prof = "Police inspectors and detectives";
ELSE IF isco08 = 3359 THEN intitu_prof = "Regulatory government associate professionals not elsewhere classified";
ELSE IF isco08 = 3400 THEN intitu_prof = "Legal, social, cultural and related associate professionals";
ELSE IF isco08 = 3410 THEN intitu_prof = "Legal, social and religious associate professionals";
ELSE IF isco08 = 3411 THEN intitu_prof = "Police inspectors and detectives";
ELSE IF isco08 = 3412 THEN intitu_prof = "Social work associate professionals";
ELSE IF isco08 = 3413 THEN intitu_prof = "Religious associate professionals";
ELSE IF isco08 = 3420 THEN intitu_prof = "Sports and fitness workers";
ELSE IF isco08 = 3421 THEN intitu_prof = "Athletes and sports players";
ELSE IF isco08 = 3422 THEN intitu_prof = "Sports coaches, instructors and officials";
ELSE IF isco08 = 3423 THEN intitu_prof = "Fitness and recreation instructors and program leaders";
ELSE IF isco08 = 3430 THEN intitu_prof = "Artistic, cultural and culinary associate professionals";
ELSE IF isco08 = 3431 THEN intitu_prof = "Photographers";
ELSE IF isco08 = 3432 THEN intitu_prof = "Interior designers and decorators";
ELSE IF isco08 = 3433 THEN intitu_prof = "Gallery, museum and library technicians";
ELSE IF isco08 = 3434 THEN intitu_prof = "Chefs";
ELSE IF isco08 = 3435 THEN intitu_prof = "Other artistic and cultural associate professionals";
ELSE IF isco08 = 3500 THEN intitu_prof = "Information and communications technicians";
ELSE IF isco08 = 3510 THEN intitu_prof = "Information and communications technology operations and user support technicians";
ELSE IF isco08 = 3511 THEN intitu_prof = "Information and communications technology operations technicians";
ELSE IF isco08 = 3512 THEN intitu_prof = "Information and communications technology user support technicians";
ELSE IF isco08 = 3513 THEN intitu_prof = "Computer network and systems technicians";
ELSE IF isco08 = 3514 THEN intitu_prof = "Web technicians";
ELSE IF isco08 = 3520 THEN intitu_prof = "Telecommunications and broadcasting technicians";
ELSE IF isco08 = 3521 THEN intitu_prof = "Broadcasting and audio-visual technicians";
ELSE IF isco08 = 3522 THEN intitu_prof = "Telecommunications engineering technicians";
ELSE IF isco08 = 4000 THEN intitu_prof = "Clerical support workers";
ELSE IF isco08 = 4100 THEN intitu_prof = "General and keyboard clerks";
ELSE IF isco08 = 4110 THEN intitu_prof = "General office clerks";
ELSE IF isco08 = 4120 THEN intitu_prof = "Secretaries (general)";
ELSE IF isco08 = 4130 THEN intitu_prof = "Keyboard operators";
ELSE IF isco08 = 4131 THEN intitu_prof = "Typists and word processing operators";
ELSE IF isco08 = 4132 THEN intitu_prof = "Data entry clerks";
ELSE IF isco08 = 4200 THEN intitu_prof = "Customer services clerks";
ELSE IF isco08 = 4210 THEN intitu_prof = "Tellers, money collectors and related clerks";
ELSE IF isco08 = 4211 THEN intitu_prof = "Bank tellers and related clerks";
ELSE IF isco08 = 4212 THEN intitu_prof = "Bookmakers, croupiers and related gaming workers";
ELSE IF isco08 = 4213 THEN intitu_prof = "Pawnbrokers and money-lenders";
ELSE IF isco08 = 4214 THEN intitu_prof = "Debt-collectors and related workers";
ELSE IF isco08 = 4220 THEN intitu_prof = "Client information workers";
ELSE IF isco08 = 4221 THEN intitu_prof = "Travel consultants and clerks";
ELSE IF isco08 = 4222 THEN intitu_prof = "Contact centre information clerks";
ELSE IF isco08 = 4223 THEN intitu_prof = "Telephone switchboard operators";
ELSE IF isco08 = 4224 THEN intitu_prof = "Hotel receptionists";
ELSE IF isco08 = 4225 THEN intitu_prof = "Enquiry clerks";
ELSE IF isco08 = 4226 THEN intitu_prof = "Receptionists (general)";
ELSE IF isco08 = 4227 THEN intitu_prof = "Survey and market research interviewers";
ELSE IF isco08 = 4229 THEN intitu_prof = "Client information workers not elsewhere classified";
ELSE IF isco08 = 4300 THEN intitu_prof = "Numerical and material recording clerks";
ELSE IF isco08 = 4310 THEN intitu_prof = "Numerical clerks";
ELSE IF isco08 = 4311 THEN intitu_prof = "Accounting and bookkeeping clerks";
ELSE IF isco08 = 4312 THEN intitu_prof = "Statistical, finance and insurance clerks";
ELSE IF isco08 = 4313 THEN intitu_prof = "Payroll clerks";
ELSE IF isco08 = 4320 THEN intitu_prof = "Material-recording and transport clerks";
ELSE IF isco08 = 4321 THEN intitu_prof = "Stock clerks";
ELSE IF isco08 = 4322 THEN intitu_prof = "Production clerks";
ELSE IF isco08 = 4323 THEN intitu_prof = "Transport clerks";
ELSE IF isco08 = 4400 THEN intitu_prof = "Other clerical support workers";
ELSE IF isco08 = 4410 THEN intitu_prof = "Other clerical support workers";
ELSE IF isco08 = 4411 THEN intitu_prof = "Library clerks";
ELSE IF isco08 = 4412 THEN intitu_prof = "Mail carriers and sorting clerks";
ELSE IF isco08 = 4413 THEN intitu_prof = "Coding, proof-reading and related clerks";
ELSE IF isco08 = 4414 THEN intitu_prof = "Scribes and related workers";
ELSE IF isco08 = 4415 THEN intitu_prof = "Filing and copying clerks";
ELSE IF isco08 = 4416 THEN intitu_prof = "Personnel clerks";
ELSE IF isco08 = 4419 THEN intitu_prof = "Clerical support workers not elsewhere classified";
ELSE IF isco08 = 5000 THEN intitu_prof = "Service and sales workers";
ELSE IF isco08 = 5100 THEN intitu_prof = "Personal service workers";
ELSE IF isco08 = 5110 THEN intitu_prof = "Travel attendants, conductors and guides";
ELSE IF isco08 = 5111 THEN intitu_prof = "Travel attendants and travel stewards";
ELSE IF isco08 = 5112 THEN intitu_prof = "Transport conductors";
ELSE IF isco08 = 5113 THEN intitu_prof = "Travel guides";
ELSE IF isco08 = 5120 THEN intitu_prof = "Cooks";
ELSE IF isco08 = 5130 THEN intitu_prof = "Waiters and bartenders";
ELSE IF isco08 = 5131 THEN intitu_prof = "Waiters";
ELSE IF isco08 = 5132 THEN intitu_prof = "Bartenders";
ELSE IF isco08 = 5140 THEN intitu_prof = "Hairdressers, beauticians and related workers";
ELSE IF isco08 = 5141 THEN intitu_prof = "Hairdressers";
ELSE IF isco08 = 5142 THEN intitu_prof = "Beauticians and related workers";
ELSE IF isco08 = 5150 THEN intitu_prof = "Building and housekeeping supervisors";
ELSE IF isco08 = 5151 THEN intitu_prof = "Cleaning and housekeeping supervisors in offices, hotels and other establishments";
ELSE IF isco08 = 5152 THEN intitu_prof = "Domestic housekeepers";
ELSE IF isco08 = 5153 THEN intitu_prof = "Building caretakers";
ELSE IF isco08 = 5160 THEN intitu_prof = "Other personal services workers";
ELSE IF isco08 = 5161 THEN intitu_prof = "Astrologers, fortune-tellers and related workers";
ELSE IF isco08 = 5162 THEN intitu_prof = "Companions and valets";
ELSE IF isco08 = 5163 THEN intitu_prof = "Undertakers and embalmers";
ELSE IF isco08 = 5164 THEN intitu_prof = "Pet groomers and animal care workers";
ELSE IF isco08 = 5165 THEN intitu_prof = "Driving instructors";
ELSE IF isco08 = 5169 THEN intitu_prof = "Personal services workers not elsewhere classified";
ELSE IF isco08 = 5200 THEN intitu_prof = "Sales workers";
ELSE IF isco08 = 5210 THEN intitu_prof = "Street and market salespersons";
ELSE IF isco08 = 5211 THEN intitu_prof = "Stall and market salespersons";
ELSE IF isco08 = 5212 THEN intitu_prof = "Street food salespersons";
ELSE IF isco08 = 5220 THEN intitu_prof = "Shop salespersons";
ELSE IF isco08 = 5221 THEN intitu_prof = "Shop keepers";
ELSE IF isco08 = 5222 THEN intitu_prof = "Shop supervisors";
ELSE IF isco08 = 5223 THEN intitu_prof = "Shop sales assistants";
ELSE IF isco08 = 5230 THEN intitu_prof = "Cashiers and ticket clerks";
ELSE IF isco08 = 5240 THEN intitu_prof = "Other sales workers";
ELSE IF isco08 = 5241 THEN intitu_prof = "Fashion and other models";
ELSE IF isco08 = 5242 THEN intitu_prof = "Sales demonstrators";
ELSE IF isco08 = 5243 THEN intitu_prof = "Door to door salespersons";
ELSE IF isco08 = 5244 THEN intitu_prof = "Contact centre salespersons";
ELSE IF isco08 = 5245 THEN intitu_prof = "Service station attendants";
ELSE IF isco08 = 5246 THEN intitu_prof = "Food service counter attendants";
ELSE IF isco08 = 5249 THEN intitu_prof = "Sales workers not elsewhere classified";
ELSE IF isco08 = 5300 THEN intitu_prof = "Personal care workers";
ELSE IF isco08 = 5310 THEN intitu_prof = "Child care workers and teachers aides";
ELSE IF isco08 = 5311 THEN intitu_prof = "Child care workers";
ELSE IF isco08 = 5312 THEN intitu_prof = "Teachers aides";
ELSE IF isco08 = 5320 THEN intitu_prof = "Personal care workers in health services";
ELSE IF isco08 = 5321 THEN intitu_prof = "Health care assistants";
ELSE IF isco08 = 5322 THEN intitu_prof = "Home-based personal care workers";
ELSE IF isco08 = 5329 THEN intitu_prof = "Personal care workers in health services not elsewhere classified";
ELSE IF isco08 = 5400 THEN intitu_prof = "Protective services workers";
ELSE IF isco08 = 5410 THEN intitu_prof = "Protective services workers";
ELSE IF isco08 = 5411 THEN intitu_prof = "Fire-fighters";
ELSE IF isco08 = 5412 THEN intitu_prof = "Police officers";
ELSE IF isco08 = 5413 THEN intitu_prof = "Prison guards";
ELSE IF isco08 = 5414 THEN intitu_prof = "Security guards";
ELSE IF isco08 = 5419 THEN intitu_prof = "Protective services workers not elsewhere classified";
ELSE IF isco08 = 6000 THEN intitu_prof = "Skilled agricultural, forestry and fishery workers";
ELSE IF isco08 = 6100 THEN intitu_prof = "Market-oriented skilled agricultural workers";
ELSE IF isco08 = 6110 THEN intitu_prof = "Market gardeners and crop growers";
ELSE IF isco08 = 6111 THEN intitu_prof = "Field crop and vegetable growers";
ELSE IF isco08 = 6112 THEN intitu_prof = "Tree and shrub crop growers";
ELSE IF isco08 = 6113 THEN intitu_prof = "Gardeners, horticultural and nursery growers";
ELSE IF isco08 = 6114 THEN intitu_prof = "Mixed crop growers";
ELSE IF isco08 = 6120 THEN intitu_prof = "Animal producers";
ELSE IF isco08 = 6121 THEN intitu_prof = "Livestock and dairy producers";
ELSE IF isco08 = 6122 THEN intitu_prof = "Poultry producers";
ELSE IF isco08 = 6123 THEN intitu_prof = "Apiarists and sericulturists";
ELSE IF isco08 = 6129 THEN intitu_prof = "Animal producers not elsewhere classified";
ELSE IF isco08 = 6130 THEN intitu_prof = "Mixed crop and animal producers";
ELSE IF isco08 = 6200 THEN intitu_prof = "Market-oriented skilled forestry, fishery and hunting workers";
ELSE IF isco08 = 6210 THEN intitu_prof = "Forestry and related workers";
ELSE IF isco08 = 6220 THEN intitu_prof = "Fishery workers, hunters and trappers";
ELSE IF isco08 = 6221 THEN intitu_prof = "Aquaculture workers";
ELSE IF isco08 = 6222 THEN intitu_prof = "Inland and coastal waters fishery workers";
ELSE IF isco08 = 6223 THEN intitu_prof = "Deep-sea fishery workers";
ELSE IF isco08 = 6224 THEN intitu_prof = "Hunters and trappers";
ELSE IF isco08 = 6300 THEN intitu_prof = "Subsistence farmers, fishers, hunters and gatherers";
ELSE IF isco08 = 6310 THEN intitu_prof = "Subsistence crop farmers";
ELSE IF isco08 = 6320 THEN intitu_prof = "Subsistence livestock farmers";
ELSE IF isco08 = 6330 THEN intitu_prof = "Subsistence mixed crop and livestock farmers";
ELSE IF isco08 = 6340 THEN intitu_prof = "Subsistence fishers, hunters, trappers and gatherers";
ELSE IF isco08 = 7000 THEN intitu_prof = "Craft and related trades workers";
ELSE IF isco08 = 7100 THEN intitu_prof = "Building and related trades workers, excluding electricians";
ELSE IF isco08 = 7110 THEN intitu_prof = "Building frame and related trades workers";
ELSE IF isco08 = 7111 THEN intitu_prof = "House builders";
ELSE IF isco08 = 7112 THEN intitu_prof = "Bricklayers and related workers";
ELSE IF isco08 = 7113 THEN intitu_prof = "Stonemasons, stone cutters, splitters and carvers";
ELSE IF isco08 = 7114 THEN intitu_prof = "Concrete placers, concrete finishers and related workers";
ELSE IF isco08 = 7115 THEN intitu_prof = "Carpenters and joiners";
ELSE IF isco08 = 7119 THEN intitu_prof = "Building frame and related trades workers not elsewhere classified";
ELSE IF isco08 = 7120 THEN intitu_prof = "Building finishers and related trades workers";
ELSE IF isco08 = 7121 THEN intitu_prof = "Roofers";
ELSE IF isco08 = 7122 THEN intitu_prof = "Floor layers and tile setters";
ELSE IF isco08 = 7123 THEN intitu_prof = "Plasterers";
ELSE IF isco08 = 7124 THEN intitu_prof = "Insulation workers";
ELSE IF isco08 = 7125 THEN intitu_prof = "Glaziers";
ELSE IF isco08 = 7126 THEN intitu_prof = "Plumbers and pipe fitters";
ELSE IF isco08 = 7127 THEN intitu_prof = "Air conditioning and refrigeration mechanics";
ELSE IF isco08 = 7130 THEN intitu_prof = "Painters, building structure cleaners and related trades workers";
ELSE IF isco08 = 7131 THEN intitu_prof = "Painters and related workers";
ELSE IF isco08 = 7132 THEN intitu_prof = "Spray painters and varnishers";
ELSE IF isco08 = 7133 THEN intitu_prof = "Building structure cleaners";
ELSE IF isco08 = 7200 THEN intitu_prof = "Metal, machinery and related trades workers";
ELSE IF isco08 = 7210 THEN intitu_prof = "Sheet and structural metal workers, moulders and welders, and related workers";
ELSE IF isco08 = 7211 THEN intitu_prof = "Metal moulders and coremakers";
ELSE IF isco08 = 7212 THEN intitu_prof = "Welders and flamecutters";
ELSE IF isco08 = 7213 THEN intitu_prof = "Sheet-metal workers";
ELSE IF isco08 = 7214 THEN intitu_prof = "Structural-metal preparers and erectors";
ELSE IF isco08 = 7215 THEN intitu_prof = "Riggers and cable splicers";
ELSE IF isco08 = 7220 THEN intitu_prof = "Blacksmiths, toolmakers and related trades workers";
ELSE IF isco08 = 7221 THEN intitu_prof = "Blacksmiths, hammersmiths and forging press workers";
ELSE IF isco08 = 7222 THEN intitu_prof = "Toolmakers and related workers";
ELSE IF isco08 = 7223 THEN intitu_prof = "Metal working machine tool setters and operators";
ELSE IF isco08 = 7224 THEN intitu_prof = "Metal polishers, wheel grinders and tool sharpeners";
ELSE IF isco08 = 7230 THEN intitu_prof = "Machinery mechanics and repairers";
ELSE IF isco08 = 7231 THEN intitu_prof = "Motor vehicle mechanics and repairers";
ELSE IF isco08 = 7232 THEN intitu_prof = "Aircraft engine mechanics and repairers";
ELSE IF isco08 = 7233 THEN intitu_prof = "Agricultural and industrial machinery mechanics and repairers";
ELSE IF isco08 = 7234 THEN intitu_prof = "Bicycle and related repairers";
ELSE IF isco08 = 7300 THEN intitu_prof = "Handicraft and printing workers";
ELSE IF isco08 = 7310 THEN intitu_prof = "Handicraft workers";
ELSE IF isco08 = 7311 THEN intitu_prof = "Precision-instrument makers and repairers";
ELSE IF isco08 = 7312 THEN intitu_prof = "Musical instrument makers and tuners";
ELSE IF isco08 = 7313 THEN intitu_prof = "Jewellery and precious-metal workers";
ELSE IF isco08 = 7314 THEN intitu_prof = "Potters and related workers";
ELSE IF isco08 = 7315 THEN intitu_prof = "Glass makers, cutters, grinders and finishers";
ELSE IF isco08 = 7316 THEN intitu_prof = "Sign writers, decorative painters, engravers and etchers";
ELSE IF isco08 = 7317 THEN intitu_prof = "Handicraft workers in wood, basketry and related materials";
ELSE IF isco08 = 7318 THEN intitu_prof = "Handicraft workers in textile, leather and related materials";
ELSE IF isco08 = 7319 THEN intitu_prof = "Handicraft workers not elsewhere classified";
ELSE IF isco08 = 7320 THEN intitu_prof = "Printing trades workers";
ELSE IF isco08 = 7321 THEN intitu_prof = "Pre-press technicians";
ELSE IF isco08 = 7322 THEN intitu_prof = "Printers";
ELSE IF isco08 = 7323 THEN intitu_prof = "Print finishing and binding workers";
ELSE IF isco08 = 7400 THEN intitu_prof = "Electrical and electronic trades workers";
ELSE IF isco08 = 7410 THEN intitu_prof = "Electrical equipment installers and repairers";
ELSE IF isco08 = 7411 THEN intitu_prof = "Building and related electricians";
ELSE IF isco08 = 7412 THEN intitu_prof = "Electrical mechanics and fitters";
ELSE IF isco08 = 7413 THEN intitu_prof = "Electrical line installers and repairers";
ELSE IF isco08 = 7420 THEN intitu_prof = "Electronics and telecommunications installers and repairers";
ELSE IF isco08 = 7421 THEN intitu_prof = "Electronics mechanics and servicers";
ELSE IF isco08 = 7422 THEN intitu_prof = "Information and communications technology installers and servicers";
ELSE IF isco08 = 7500 THEN intitu_prof = "Food processing, wood working, garment and other craft and related trades workers";
ELSE IF isco08 = 7510 THEN intitu_prof = "Food processing and related trades workers";
ELSE IF isco08 = 7511 THEN intitu_prof = "Butchers, fishmongers and related food preparers";
ELSE IF isco08 = 7512 THEN intitu_prof = "Bakers, pastry-cooks and confectionery makers";
ELSE IF isco08 = 7513 THEN intitu_prof = "Dairy-products makers";
ELSE IF isco08 = 7514 THEN intitu_prof = "Fruit, vegetable and related preservers";
ELSE IF isco08 = 7515 THEN intitu_prof = "Food and beverage tasters and graders";
ELSE IF isco08 = 7516 THEN intitu_prof = "Tobacco preparers and tobacco products makers";
ELSE IF isco08 = 7520 THEN intitu_prof = "Wood treaters, cabinet-makers and related trades workers";
ELSE IF isco08 = 7521 THEN intitu_prof = "Wood treaters";
ELSE IF isco08 = 7522 THEN intitu_prof = "Cabinet-makers and related workers";
ELSE IF isco08 = 7523 THEN intitu_prof = "Woodworking-machine tool setters and operators";
ELSE IF isco08 = 7530 THEN intitu_prof = "Garment and related trades workers";
ELSE IF isco08 = 7531 THEN intitu_prof = "Tailors, dressmakers, furriers and hatters";
ELSE IF isco08 = 7532 THEN intitu_prof = "Garment and related pattern-makers and cutters";
ELSE IF isco08 = 7533 THEN intitu_prof = "Sewing, embroidery and related workers";
ELSE IF isco08 = 7534 THEN intitu_prof = "Upholsterers and related workers";
ELSE IF isco08 = 7535 THEN intitu_prof = "Pelt dressers, tanners and fellmongers";
ELSE IF isco08 = 7536 THEN intitu_prof = "Shoemakers and related workers";
ELSE IF isco08 = 7540 THEN intitu_prof = "Other craft and related workers";
ELSE IF isco08 = 7541 THEN intitu_prof = "Underwater divers";
ELSE IF isco08 = 7542 THEN intitu_prof = "Shotfirers and blasters";
ELSE IF isco08 = 7543 THEN intitu_prof = "Product graders and testers (excluding foods and beverages)";
ELSE IF isco08 = 7544 THEN intitu_prof = "Fumigators and other pest and weed controllers";
ELSE IF isco08 = 7549 THEN intitu_prof = "Craft and related workers not elsewhere classified";
ELSE IF isco08 = 8000 THEN intitu_prof = "Plant and machine operators, and assemblers";
ELSE IF isco08 = 8100 THEN intitu_prof = "Stationary plant and machine operators";
ELSE IF isco08 = 8110 THEN intitu_prof = "Mining and mineral processing plant operators";
ELSE IF isco08 = 8111 THEN intitu_prof = "Miners and quarriers";
ELSE IF isco08 = 8112 THEN intitu_prof = "Mineral and stone processing plant operators";
ELSE IF isco08 = 8113 THEN intitu_prof = "Well drillers and borers and related workers";
ELSE IF isco08 = 8114 THEN intitu_prof = "Cement, stone and other mineral products machine operators";
ELSE IF isco08 = 8120 THEN intitu_prof = "Metal processing and finishing plant operators";
ELSE IF isco08 = 8121 THEN intitu_prof = "Metal processing plant operators";
ELSE IF isco08 = 8122 THEN intitu_prof = "Metal finishing, plating and coating machine operators";
ELSE IF isco08 = 8130 THEN intitu_prof = "Chemical and photographic products plant and machine operators";
ELSE IF isco08 = 8131 THEN intitu_prof = "Chemical products plant and machine operators";
ELSE IF isco08 = 8132 THEN intitu_prof = "Photographic products machine operators";
ELSE IF isco08 = 8140 THEN intitu_prof = "Rubber, plastic and paper products machine operators";
ELSE IF isco08 = 8141 THEN intitu_prof = "Rubber products machine operators";
ELSE IF isco08 = 8142 THEN intitu_prof = "Plastic products machine operators";
ELSE IF isco08 = 8143 THEN intitu_prof = "Paper products machine operators";
ELSE IF isco08 = 8150 THEN intitu_prof = "Textile, fur and leather products machine operators";
ELSE IF isco08 = 8151 THEN intitu_prof = "Fibre preparing, spinning and winding machine operators";
ELSE IF isco08 = 8152 THEN intitu_prof = "Weaving and knitting machine operators";
ELSE IF isco08 = 8153 THEN intitu_prof = "Sewing machine operators";
ELSE IF isco08 = 8154 THEN intitu_prof = "Bleaching, dyeing and fabric cleaning machine operators";
ELSE IF isco08 = 8155 THEN intitu_prof = "Fur and leather preparing machine operators";
ELSE IF isco08 = 8156 THEN intitu_prof = "Shoemaking and related machine operators";
ELSE IF isco08 = 8157 THEN intitu_prof = "Laundry machine operators";
ELSE IF isco08 = 8159 THEN intitu_prof = "Textile, fur and leather products machine operators not elsewhere classified";
ELSE IF isco08 = 8160 THEN intitu_prof = "Food and related products machine operators";
ELSE IF isco08 = 8170 THEN intitu_prof = "Wood processing and papermaking plant operators";
ELSE IF isco08 = 8171 THEN intitu_prof = "Pulp and papermaking plant operators";
ELSE IF isco08 = 8172 THEN intitu_prof = "Wood processing plant operators";
ELSE IF isco08 = 8180 THEN intitu_prof = "Other stationary plant and machine operators";
ELSE IF isco08 = 8181 THEN intitu_prof = "Glass and ceramics plant operators";
ELSE IF isco08 = 8182 THEN intitu_prof = "Steam engine and boiler operators";
ELSE IF isco08 = 8183 THEN intitu_prof = "Packing, bottling and labelling machine operators";
ELSE IF isco08 = 8189 THEN intitu_prof = "Stationary plant and machine operators not elsewhere classified";
ELSE IF isco08 = 8200 THEN intitu_prof = "Assemblers";
ELSE IF isco08 = 8210 THEN intitu_prof = "Assemblers";
ELSE IF isco08 = 8211 THEN intitu_prof = "Mechanical machinery assemblers";
ELSE IF isco08 = 8212 THEN intitu_prof = "Electrical and electronic equipment assemblers";
ELSE IF isco08 = 8219 THEN intitu_prof = "Assemblers not elsewhere classified";
ELSE IF isco08 = 8300 THEN intitu_prof = "Drivers and mobile plant operators";
ELSE IF isco08 = 8310 THEN intitu_prof = "Locomotive engine drivers and related workers";
ELSE IF isco08 = 8311 THEN intitu_prof = "Locomotive engine drivers";
ELSE IF isco08 = 8312 THEN intitu_prof = "Railway brake, signal and switch operators";
ELSE IF isco08 = 8320 THEN intitu_prof = "Car, van and motorcycle drivers";
ELSE IF isco08 = 8321 THEN intitu_prof = "Motorcycle drivers";
ELSE IF isco08 = 8322 THEN intitu_prof = "Car, taxi and van drivers";
ELSE IF isco08 = 8330 THEN intitu_prof = "Heavy truck and bus drivers";
ELSE IF isco08 = 8331 THEN intitu_prof = "Bus and tram drivers";
ELSE IF isco08 = 8332 THEN intitu_prof = "Heavy truck and lorry drivers";
ELSE IF isco08 = 8340 THEN intitu_prof = "Mobile plant operators";
ELSE IF isco08 = 8341 THEN intitu_prof = "Mobile farm and forestry plant operators";
ELSE IF isco08 = 8342 THEN intitu_prof = "Earthmoving and related plant operators";
ELSE IF isco08 = 8343 THEN intitu_prof = "Crane, hoist and related plant operators";
ELSE IF isco08 = 8344 THEN intitu_prof = "Lifting truck operators";
ELSE IF isco08 = 8350 THEN intitu_prof = "Ships deck crews and related workers";
ELSE IF isco08 = 9000 THEN intitu_prof = "Elementary occupations";
ELSE IF isco08 = 9100 THEN intitu_prof = "Cleaners and helpers";
ELSE IF isco08 = 9110 THEN intitu_prof = "Domestic, hotel and office cleaners and helpers";
ELSE IF isco08 = 9111 THEN intitu_prof = "Domestic cleaners and helpers";
ELSE IF isco08 = 9112 THEN intitu_prof = "Cleaners and helpers in offices, hotels and other establishments";
ELSE IF isco08 = 9120 THEN intitu_prof = "Vehicle, window, laundry and other hand cleaning workers";
ELSE IF isco08 = 9121 THEN intitu_prof = "Hand launderers and pressers";
ELSE IF isco08 = 9122 THEN intitu_prof = "Vehicle cleaners";
ELSE IF isco08 = 9123 THEN intitu_prof = "Window cleaners";
ELSE IF isco08 = 9129 THEN intitu_prof = "Other cleaning workers";
ELSE IF isco08 = 9200 THEN intitu_prof = "Agricultural, forestry and fishery labourers";
ELSE IF isco08 = 9210 THEN intitu_prof = "Agricultural, forestry and fishery labourers";
ELSE IF isco08 = 9211 THEN intitu_prof = "Crop farm labourers";
ELSE IF isco08 = 9212 THEN intitu_prof = "Livestock farm labourers";
ELSE IF isco08 = 9213 THEN intitu_prof = "Mixed crop and livestock farm labourers";
ELSE IF isco08 = 9214 THEN intitu_prof = "Garden and horticultural labourers";
ELSE IF isco08 = 9215 THEN intitu_prof = "Forestry labourers";
ELSE IF isco08 = 9216 THEN intitu_prof = "Fishery and aquaculture labourers";
ELSE IF isco08 = 9300 THEN intitu_prof = "Labourers in mining, construction, manufacturing and transport";
ELSE IF isco08 = 9310 THEN intitu_prof = "Mining and construction labourers";
ELSE IF isco08 = 9311 THEN intitu_prof = "Mining and quarrying labourers";
ELSE IF isco08 = 9312 THEN intitu_prof = "Civil engineering labourers";
ELSE IF isco08 = 9313 THEN intitu_prof = "Building construction labourers";
ELSE IF isco08 = 9320 THEN intitu_prof = "Manufacturing labourers";
ELSE IF isco08 = 9321 THEN intitu_prof = "Hand packers";
ELSE IF isco08 = 9329 THEN intitu_prof = "Manufacturing labourers not elsewhere classified";
ELSE IF isco08 = 9330 THEN intitu_prof = "Transport and storage labourers";
ELSE IF isco08 = 9331 THEN intitu_prof = "Hand and pedal vehicle drivers";
ELSE IF isco08 = 9332 THEN intitu_prof = "Drivers of animal-drawn vehicles and machinery";
ELSE IF isco08 = 9333 THEN intitu_prof = "Freight handlers";
ELSE IF isco08 = 9334 THEN intitu_prof = "Shelf fillers";
ELSE IF isco08 = 9400 THEN intitu_prof = "Food preparation assistants";
ELSE IF isco08 = 9410 THEN intitu_prof = "Food preparation assistants";
ELSE IF isco08 = 9411 THEN intitu_prof = "Fast food preparers";
ELSE IF isco08 = 9412 THEN intitu_prof = "Kitchen helpers";
ELSE IF isco08 = 9500 THEN intitu_prof = "Street and related sales and service workers";
ELSE IF isco08 = 9510 THEN intitu_prof = "Street and related service workers";
ELSE IF isco08 = 9520 THEN intitu_prof = "Street vendors (excluding food)";
ELSE IF isco08 = 9600 THEN intitu_prof = "Refuse workers and other elementary workers";
ELSE IF isco08 = 9610 THEN intitu_prof = "Refuse workers";
ELSE IF isco08 = 9611 THEN intitu_prof = "Garbage and recycling collectors";
ELSE IF isco08 = 9612 THEN intitu_prof = "Refuse sorters";
ELSE IF isco08 = 9613 THEN intitu_prof = "Sweepers and related labourers";
ELSE IF isco08 = 9620 THEN intitu_prof = "Other elementary workers";
ELSE IF isco08 = 9621 THEN intitu_prof = "Messengers, package deliverers and luggage porters";
ELSE IF isco08 = 9622 THEN intitu_prof = "Odd job persons";
ELSE IF isco08 = 9623 THEN intitu_prof = "Meter readers and vending-machine collectors";
ELSE IF isco08 = 9624 THEN intitu_prof = "Water and firewood collectors";
ELSE IF isco08 = 9629 THEN intitu_prof = "Elementary workers not elsewhere classified";
RUN;

data france;
   set france;  
   longueur_prof = length(intitu_prof);
run;

PROC MEANS DATA=france MEAN;
CLASS longueur_prof;
VAR happy;
OUTPUT OUT=france MEAN=moyenneHappy6;
RUN;

TITLE "Corrélation de Pearson entre bonheur moyen et nombre de caractères dans l'intitulé de profession";
PROC CORR DATA=france;
   VAR moyenneHappy6 longueur_prof;
run;

/* On s'interesse au partenaire maintenant */

DATA france;
SET france;
LENGTH pcsp$ 50;
IF isco08p >= "0" AND isco08p <= 999 THEN pcsp= "5";
ELSE IF isco08p >= 1000 AND isco08p <= 1999 THEN pcsp= "3";
ELSE IF isco08p >= 2000 AND isco08p <= 2199 THEN pcsp= "3";
ELSE IF isco08p >= 2200 AND isco08p <= 2299 THEN pcsp= "3";
ELSE IF isco08p >= 2300 AND isco08p <= 2399 THEN pcsp= "3";
ELSE IF isco08p >= 2400 AND isco08p <= 2499 THEN pcsp= "3";
ELSE IF isco08p >= 2500 AND isco08p <= 2599 THEN pcsp= "3";
ELSE IF isco08p >= 2600 AND isco08p <= 2619 THEN pcsp= "3";
ELSE IF isco08p >= 2620 AND isco08p <= 2699 THEN pcsp= "3";
ELSE IF isco08p >= 3000 AND isco08p <= 3215 THEN pcsp= "4";
ELSE IF isco08p >= 3220 AND isco08p <= 3299 THEN pcsp= "4";
ELSE IF isco08p >= 3300 AND isco08p <= 3399 THEN pcsp= "4";
ELSE IF isco08p >= 3400 AND isco08p <= 3499 THEN pcsp= "4";
ELSE IF isco08p >= 3500 AND isco08p <= 3999 THEN pcsp= "4";
ELSE IF isco08p >= 4000 AND isco08p <= 4999 THEN pcsp= "5";
ELSE IF isco08p >= 5000 AND isco08p <= 5999 THEN pcsp= "5";
ELSE IF isco08p >= 6000 AND isco08p <= 6999 THEN pcsp= "1";
ELSE IF isco08p >= 7000 AND isco08p <= 7999 THEN pcsp= "2";
ELSE IF isco08p >= 8000 AND isco08p <= 8999 THEN pcsp= "6";
ELSE IF isco08p >= 9000 AND isco08p <= 9999 THEN pcsp= "6";
ELSE metierp = "Autre";
RUN;



DATA france;
LENGTH metierp $ 100;
SET france;
IF isco08p >= 0 AND isco08p <= 999 THEN metierp = "Armee";
ELSE IF isco08p >= 1000 AND isco08p <= 1999 THEN metierp = "Cadres et dirigeants";
ELSE IF isco08p >= 2000 AND isco08p <= 2199 THEN metierp = "Ingenieurs";
ELSE IF isco08p >= 2200 AND isco08p <= 2299 THEN metierp = "Medecins";
ELSE IF isco08p >= 2300 AND isco08p <= 2399 THEN metierp = "Enseignants";
ELSE IF isco08p >= 2400 AND isco08p <= 2499 THEN metierp = "Finances et marketing";
ELSE IF isco08p >= 2500 AND isco08p <= 2599 THEN metierp = "Ingenieurs informatique";
ELSE IF isco08p >= 2600 AND isco08p <= 2619 THEN metierp = "Professions du droit";
ELSE IF isco08p >= 2620 AND isco08p <= 2699 THEN metierp = "Arts et littérature";
ELSE IF isco08p >= 3000 AND isco08p <= 3215 THEN metierp = "Techniciens";
ELSE IF isco08p >= 3220 AND isco08p <= 3299 THEN metierp = "Infirmiers";
ELSE IF isco08p >= 3300 AND isco08p <= 3399 THEN metierp = "Regulation";
ELSE IF isco08p >= 3400 AND isco08p <= 3499 THEN metierp = "Culture";
ELSE IF isco08p >= 3500 AND isco08p <= 3999 THEN metierp = "Techniciens de la communication";
ELSE IF isco08p >= 4000 AND isco08p <= 4999 THEN metierp = "Administration";
ELSE IF isco08p >= 5000 AND isco08p <= 5999 THEN metierp = "Services particuliers";
ELSE IF isco08p >= 6000 AND isco08p <= 6999 THEN metierp = "Agriculteurs";
ELSE IF isco08p >= 7000 AND isco08p <= 7999 THEN metierp = "Artisans";
ELSE IF isco08p >= 8000 AND isco08p <= 8999 THEN metierp = "Conducteurs et chauffeurs";
ELSE IF isco08p >= 9000 AND isco08p <= 9999 THEN metierp = "Taches menageres";
ELSE metierp = "Autre";
RUN;


/* Calcul de la moyenne par catégorie */
PROC MEANS DATA=france MEAN;
CLASS metierp;
VAR happy;
OUTPUT OUT=moyennes MEAN=moyenneHappy;
RUN;

/* Définition du graphique en bâtons avec la procédure VBAR */
TITLE "Bonheur moyen en fonction du métier du partenaire ";
VBAR metierp / RESPONSE=moyenneHappy CATEGORYORDER=RESPDESC;
RUN;


PROC MEANS DATA=france MEAN;
where gndr=1;
CLASS metierp;
VAR happy;
OUTPUT OUT=moyennes MEAN=moyenneHappy;
RUN;

TITLE "Bonheur moyen en fonction du métier du partenaire chez les hommes";
PROC SGPLOT DATA=moyennes;
VBAR metierp / RESPONSE=moyenneHappy CATEGORYORDER=RESPDESC;
RUN;

PROC MEANS DATA=france MEAN;
where gndr=2;
CLASS metierp;
VAR happy;
OUTPUT OUT=moyennes MEAN=moyenneHappy;
RUN;

TITLE "Bonheur moyen en fonction du métier du partenaire chez les femmes";
PROC SGPLOT DATA=moyennes;
VBAR metierp / RESPONSE=moyenneHappy CATEGORYORDER=RESPDESC;
RUN;


TITLE "Bonheur moyen en fonction de si les deux partenaires ont la même profession ou non";
PROC MEANS DATA=france MEAN;
CLASS memeprofession;
VAR happy;
RUN;

proc sort data=france;
by memeprofession;
run;

proc boxplot data=france;
plot happy*memeprofession;
run;

data france;
SET france;
IF metier = metierp THEN mememetier = "Identique";
ELSE mememetier = "Different";
RUN;



TITLE "Bonheur moyen en fonction de si les deux partenaires ont le même métier ou non";
PROC MEANS DATA=france MEAN;
CLASS mememetier;
VAR happy;
RUN;

proc sort data=france;
by mememetier;
run;

proc boxplot data=france;
plot happy*mememetier;
run;


data france;
SET france;
IF pcs = pcsp THEN memepcs = "Identique";
ELSE memepcs = "Different";
RUN;

TITLE "Bonheur moyen en fonction de si les deux partenaires ont la même catégorie socioprofessionnelle ou non";
PROC MEANS DATA=france MEAN;
CLASS memepcs;
VAR happy;
RUN;

proc sort data=france;
by memepcs;
run;

proc boxplot data=france;
plot happy*memepcs;
run;

TITLE "Corrélation de Pearson entre bonheur moyen et sentiment à l'égard du revenu";
PROC CORR DATA=france;
   VAR happy hincfel;
run;

TITLE "Sentiment moyen vis à vis de la rémunération par métiers";
PROC MEANS DATA=france MEAN;
CLASS metier;
VAR hincfel;
WHERE metier <> "Autre";
RUN;

PROC UNIVARIATE DATA = france;
VAR hincfel;
WHERE metier <> "Autre";
RUN;

TITLE "Corrélation de Pearson entre bonheur moyen et satisfaction temps de travail";
PROC CORR DATA=france;
   VAR happy stfjbot;
   WHERE stfjbot<=10;
run;

TITLE "Sentiment moyen vis à vis de la répartition temps travail et libre";
PROC MEANS DATA=france MEAN;
CLASS metier;
VAR stfjbot;
WHERE metier <> "Autre" AND stfjbot<=10;
RUN;

PROC UNIVARIATE DATA = france;
VAR stfjbot;
WHERE metier <> "Autre" AND stfjbot<=10;
RUN;
