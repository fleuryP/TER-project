---------------------------------------------------
-- Script postgre remplissage tables

-- BENJAOUR Salwa
-- FLEURY Pierre
-- JORDAN Célia
---------------------------------------------------





--------------------- Table Personne ---------------------

-- Identifiant
INSERT INTO personne (id) SELECT v002 FROM "3B_donnees_brutes"

-- Année de naissance
INSERT INTO personne (annee_naissance) SELECT annee FROM "3B_donnees_brutes"
	WHERE 'type.lieu' = 'Nais'

-- Lieu de naissance
INSERT INTO personne (lieu_naissance) SELECT nom_commune FROM "3B_donnees_brutes"
	WHERE 'type.lieu' = 'Nais'  
	
-- Type
INSERT INTO personne ('type') SELECT pers FROM "3B_donnees_brutes"
	
-- Rang
INSERT INTO personne (rang) SELECT rang FROM "3B_donnees_brutes"

-- Nombre de mariages, précision seulement de 1 ou plusieurs
INSERT INTO personne (nombre_mariage) SELECT rang FROM "3B_donnees_brutes"
	WHERE max(typelieu='Mar')

--------------------- Table leisure_trajectory ---------------------


--------------------- Table leisure_event ---------------------


--------------------- Table leisure_episode ---------------------


--------------------- Table familial_trajectory ---------------------


--------------------- Table familial_event ---------------------


--------------------- Table familial_episode ---------------------


--------------------- Table professionnal_trajectory ---------------------


--------------------- Table professionnal_event ---------------------


--------------------- Table professionnal_episode ---------------------


--------------------- Table residential_trajectory ---------------------


--------------------- Table residential_event ---------------------


--------------------- Table residential_episode ---------------------


