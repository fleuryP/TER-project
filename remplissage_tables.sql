---------------------------------------------------
-- Script postgre remplissage tables

-- BENKAOUR Salwa
-- FLEURY Pierre
-- JORDAN Célia
---------------------------------------------------




--------------------- Table Personne ---------------------

-- Identifiant
INSERT INTO personne (id, annee_naissance, commune)
	SELECT DISTINCT v002,
		min(annee) AS annee_naissance,
		min(nom_commune) AS lieu_naissance
	FROM "3B_donnees_brutes"
	WHERE (type_lieu='Nais' AND Pers='Ego') OR Pers='Ego' 
	GROUP BY v002 ORDER BY v002;
	
UPDATE personne SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = personne.commune;

ALTER TABLE personne DROP COLUMN commune;

SELECT * FROM public.personne
ORDER BY id ASC LIMIT 100;
--------------------- Table Conjoint ---------------------
INSERT INTO conjoint (ref_id,annee_naissance,commune) 
	SELECT v002,annee,nom_commune
	FROM "3B_donnees_brutes"
	WHERE type_lieu='Nais' AND Pers='Cjt' ;
	
UPDATE conjoint SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = conjoint.commune;

ALTER TABLE conjoint DROP COLUMN commune;

SELECT * FROM public.conjoint
ORDER BY ref_id ASC LIMIT 100;
--------------------- Table Parent ---------------------
INSERT INTO parent (ref_id, rang, annee_naissance, commune) 
	SELECT v002,rang,annee,nom_commune
	FROM "3B_donnees_brutes"
	WHERE type_lieu='Nais' AND Pers='Par';
	
UPDATE parent SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = parent.commune;

ALTER TABLE parent DROP COLUMN commune;

SELECT * FROM public.parent
ORDER BY ref_id ASC LIMIT 100;
--------------------- Table Enfant ---------------------
INSERT INTO enfant (ref_id, rang, annee_naissance,commune) 
	SELECT v002, rang,annee,nom_commune
	FROM "3B_donnees_brutes"
	WHERE type_lieu='Nais' AND Pers='Enf';
	
UPDATE enfant SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = enfant.commune;

ALTER TABLE enfant DROP COLUMN commune;
	
SELECT * FROM public.enfant
ORDER BY ref_id ASC LIMIT 100;
--------------------- Table Localisation ---------------------
INSERT INTO localisation (commune,departement, pays,tu,longitude,latitude) -- , type_commune) 
	SELECT DISTINCT nom_commune, depcom,pays,tu,CAST(longitude AS numeric),CAST(latitude AS numeric)
		FROM "3B_donnees_brutes" WHERE (longitude !='NA' AND latitude !='NA');

ALTER TABLE localisation ADD COLUMN geom geometry(Point, 4326);
UPDATE localisation SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);


SELECT * FROM public.localisation
ORDER BY ref_loc ASC LIMIT 100
--------------------- Table residential_trajectory ---------------------
INSERT INTO residential_trajectory (ref_rt, personne)
SELECT residential_episode.ref_rt, residential_episode.personne FROM residential_event
INNER JOIN residential_episode ON  residential_episode.ref_rt = residential_event.ref_rt;

--------------------- Table residential_episode ---------------------
INSERT INTO residential_episode(personne, rang, type_episode, date_debut, date_fin, commune) 
	SELECT v002, rang, type_lieu, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Res' OR type_lieu='Pens') 
		GROUP BY v002, type_lieu,rang, nom_commune
		ORDER BY v002;
		
UPDATE residential_episode SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = residential_episode.commune;

ALTER TABLE residential_episode DROP COLUMN commune;

SELECT * FROM public.residential_episode
ORDER BY personne ASC LIMIT 100;
--------------------- Table residential_event ---------------------
INSERT INTO residential_event(personne,rang, type_event, annee, commune)  
	SELECT v002, rang, 'premier logement' AS type_event, min(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Res' OR type_lieu='Pens') AND rang='1'
		GROUP BY v002, type_lieu, nom_commune,rang
		UNION
	SELECT v002, rang, 'demenagement' AS type_event, min(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Res' OR type_lieu='Pens') AND rang!='1'
		GROUP BY v002, type_lieu, nom_commune,rang
		ORDER BY v002,rang;
		
UPDATE residential_event SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = residential_event.commune;

ALTER TABLE residential_event DROP COLUMN commune;
		
SELECT * FROM public.residential_event
ORDER BY personne,year ASC LIMIT 100;
--------------------- Table familial_trajectory ---------------------
INSERT INTO familial_trajectory (ref_ft, personne)
SELECT familial_episode.ref_ft, familial_episode.personne FROM familial_event
INNER JOIN familial_episode ON  familial_episode.ref_ft = familial_event.ref_ft;

--------------------- Table familial_episode ---------------------
INSERT INTO familial_episode(personne, type_episode, date_debut, date_fin,commune) 
		SELECT v002, 'Jeunesse', min(annee) as anneeMin, max(annee) as anneeMax,nom_commune FROM "3B_donnees_brutes" 
        WHERE (pers='Ego' OR pers='Enf') AND type_lieu='Nais' AND rang ='1'
        GROUP BY v002,nom_commune
        UNION
        SELECT v002, 'Parent', min(annee) as anneeMin, '1981' as anneeMax,nom_commune FROM "3B_donnees_brutes" 
        WHERE pers='Enf' AND type_lieu='Nais' AND rang ='1'
        GROUP BY v002,nom_commune
        UNION
        SELECT v002, 'Marie', min(annee) as anneeMin, '1981' as anneeMax,nom_commune FROM "3B_donnees_brutes" 
        WHERE pers='Ego' AND type_lieu='Mar' AND rang ='1'
        GROUP BY v002,nom_commune
        ORDER BY v002, anneeMin;
		
UPDATE familial_episode SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = familial_episode.commune;

ALTER TABLE familial_episode DROP COLUMN commune;

SELECT * FROM public.familial_episode
ORDER BY personne, date_debut ASC LIMIT 100;

--------------------- Table familial_event ---------------------
INSERT INTO familial_event(personne, type_event,rang, annee, commune) 
		SELECT v002,'Naissance enfant',rang, annee, nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Enf' AND type_lieu='Nais' AND rang ='1'
		GROUP BY v002, type_lieu, Pers, nom_commune,annee,rang
	UNION
		SELECT v002,'Naissance',rang, annee, nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND type_lieu='Nais'
		GROUP BY v002, type_lieu, nom_commune,annee,rang
	UNION
		SELECT v002,'Mariage',rang, annee, nom_commune FROM "3B_donnees_brutes"
		WHERE pers='Ego' AND type_lieu='Mar' AND rang ='1'
		GROUP BY v002, type_lieu, nom_commune,annee,rang
		
UPDATE familial_event SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = familial_event.commune;

ALTER TABLE familial_event DROP COLUMN commune;
		
SELECT * FROM public.familial_event
ORDER BY personne,year ASC LIMIT 100;

--------------------- Table professionnal_trajectory ---------------------
INSERT INTO professionnal_trajectory (ref_pt, personne)
SELECT professionnal_episode.ref_pt, professionnal_episode.personne FROM professionnal_event
INNER JOIN professionnal_episode ON  professionnal_episode.ref_pt = professionnal_event.ref_pt;

--------------------- Table professionnal_episode ---------------------
INSERT INTO professionnal_episode(personne, type_episode, rang, date_debut, date_fin, commune)  
	SELECT v002, 'Emploi', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes"
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='1'  
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Chomage', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes"
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='2'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Militaire', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='3'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Maladie longue duree', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='4'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Etudes', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='5'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Retraite', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='6'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Au foyer', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='7'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Divers', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='8'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'Guerre', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes"
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='0'
		GROUP BY v002, type_lieu, rang, nom_commune
	UNION 
	SELECT v002, 'NA', rang, min(annee), max(annee), nom_commune FROM "3B_donnees_brutes"
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu') AND activity='NA'
		GROUP BY v002, type_lieu, rang, nom_commune
		ORDER BY v002;
		
UPDATE professionnal_episode SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = professionnal_episode.commune;

ALTER TABLE professionnal_episode DROP COLUMN commune;
		
SELECT * FROM public.professionnal_episode
ORDER BY personne,rang ASC LIMIT 100;
--------------------- Table professionnal_event ---------------------
INSERT INTO professionnal_event(personne, type_event, annee, commune, rang)  
SELECT v002, 'changement d emploi', min(annee) AS year, nom_commune, rang FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Work' OR type_lieu='Etu')
		GROUP BY v002, type_lieu, nom_commune,rang
		ORDER BY v002,year;
		
UPDATE professionnal_event SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = professionnal_event.commune;

ALTER TABLE professionnal_event DROP COLUMN commune;

SELECT * FROM public.professionnal_event
ORDER BY personne,year ASC LIMIT 100;
--------------------- Table leisure_trajectory ---------------------
INSERT INTO leisure_trajectory (ref_lt, personne)
SELECT leisure_episode.ref_lt, leisure_episode.personne FROM leisure_event
INNER JOIN leisure_episode ON  leisure_episode.ref_lt = leisure_event.ref_lt;

--------------------- Table leisure_episode ---------------------
INSERT INTO leisure_episode(personne, type_episode, rang, date_debut, date_fin, commune)  
SELECT	v002, type_lieu,
		rang,
		min(annee),
		max(annee),
		nom_commune 
		FROM "3B_donnees_brutes"
		WHERE pers='Ego' AND (type_lieu='Proj' OR type_lieu='Att' OR type_lieu='Sejour') 
		GROUP BY  v002,type_lieu, rang, nom_commune;

UPDATE leisure_episode SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = leisure_episode.commune;

ALTER TABLE leisure_episode DROP COLUMN commune;
		
--------------------- Table leisure_event ---------------------

INSERT INTO leisure_event(personne,type_event, annee, commune, rang) 
	SELECT v002,'voyage',annee, nom_commune,rang FROM "3B_donnees_brutes" 
		WHERE pers='Ego' AND (type_lieu='Proj' OR type_lieu='Att' OR type_lieu='Sejour') 
		GROUP BY v002, type_lieu, rang, nom_commune, annee
		ORDER BY v002;
		
UPDATE leisure_event SET ref_loc = localisation.ref_loc FROM localisation
WHERE localisation.commune = leisure_event.commune;

ALTER TABLE leisure_event DROP COLUMN commune;

