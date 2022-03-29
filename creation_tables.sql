---------------------------------------------------
-- Script postgre création tables

-- BENKAOUR Salwa
-- FLEURY Pierre
-- JORDAN Célia
---------------------------------------------------




---------------------------------------------------
-- Création de la table "personne"
---------------------------------------------------

CREATE TABLE personne (
    id CHARACTER(5),
    annee_naissance CHARACTER(5) ,          -- annee de naissance
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (id)
);


---------------------------------------------------
-- Création des tables "parent"
---------------------------------------------------
CREATE TABLE parent (
    ref_id CHARACTER(5) REFERENCES personne (id),           -- 
    rang CHARACTER(2),
	annee_naissance CHARACTER(5),           -- 
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_id, rang)
);

---------------------------------------------------
-- Création des tables "enfant"
---------------------------------------------------
CREATE TABLE enfant (
    ref_id CHARACTER(5) REFERENCES personne (id),           
	rang CHARACTER(5),
    annee_naissance CHARACTER(5),
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_id, rang)
);


---------------------------------------------------
-- Création des tables "conjoint"
---------------------------------------------------
CREATE TABLE conjoint (
    ref_id CHARACTER(5) REFERENCES personne (id),           -- 
    annee_naissance CHARACTER(5),           -- 
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_id) 
);


---------------------------------------------------
-- Création des tables "localisation"
---------------------------------------------------
CREATE TABLE localisation (
    ref_loc SERIAL,
	commune CHARACTER(50),           -- 
    departement CHARACTER(5),           -- 
	code_postal CHARACTER(2),           --
    type_commune CHARACTER(20),           -- 
	pays CHARACTER(20),
	TU CHARACTER (2),
	longitude double precision,
	latitude double precision,
	--geom POINT, --(lat, long) => WGS84
	PRIMARY KEY (ref_loc)
);


---------------------------------------------------
-- Création des tables "résidentielles"
---------------------------------------------------

CREATE TABLE residential_trajectory (
	ref_rt SERIAL,
	personne CHARACTER (5) REFERENCES personne(id),
	PRIMARY KEY (ref_rt,personne),
	FOREIGN KEY (ref_rt) REFERENCES residential_episode(ref_rt),
	FOREIGN KEY (ref_rt) REFERENCES residential_event(ref_rt)
);

CREATE TABLE residential_episode (
	ref_rt SERIAL,
	personne CHARACTER (5),
    rang CHARACTER(2),           -- 
    type_episode CHARACTER(20),           -- 
	date_debut CHARACTER(5), 		   -- Date de début de l'épisode
	date_fin CHARACTER(5), 		   -- Date de fin de l'épisode
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_rt)
);

CREATE TABLE residential_event (
	ref_rt SERIAL,
	personne CHARACTER (5),
    rang CHARACTER(2),           -- 
    type_event CHARACTER(20),           -- 
    annee CHARACTER(20),           -- 
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_rt)
);


---------------------------------------------------
-- Création des tables "professionnelles"
---------------------------------------------------
CREATE TABLE professionnal_trajectory (
	ref_pt SERIAL,
	personne CHARACTER (5) REFERENCES personne(id),
	PRIMARY KEY (ref_pt, personne),
	FOREIGN KEY (ref_pt) REFERENCES professionnal_episode (ref_pt),
	FOREIGN KEY (ref_pt) REFERENCES professionnal_event (ref_pt)
);

CREATE TABLE professionnal_episode (
	ref_pt SERIAL, 			 --
	personne CHARACTER(5),			--
    type_episode CHARACTER(20),           -- 
    rang CHARACTER(2),           -- 
	date_debut CHARACTER(5), 		   -- Date de début de l'épisode
	date_fin CHARACTER(5), 		   -- Date de fin de l'épisode
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_pt)
);

CREATE TABLE professionnal_event (
	ref_pt SERIAL,           -- 
    personne CHARACTER(5),
	type_event CHARACTER(20),           -- 
	annee CHARACTER(5),           -- 
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),	
	rang CHARACTER(2),			  --
	PRIMARY KEY (ref_pt)
);


---------------------------------------------------
-- Création des tables "familiales"
---------------------------------------------------

CREATE TABLE familial_trajectory (
	ref_ft SERIAL,
	personne CHARACTER (5) REFERENCES personne(id),
	PRIMARY KEY (ref_ft, personne),
	FOREIGN KEY (ref_ft) REFERENCES familial_episode (ref_ft),
	FOREIGN KEY (ref_ft) REFERENCES familial_event (ref_ft)
);

CREATE TABLE familial_episode (
	ref_ft SERIAL, 			 --
	personne CHARACTER(5),			--
	type_episode CHARACTER(20),			--
	rang CHARACTER(2),			--
    status CHARACTER(20),         -- 
	date_debut CHARACTER(5), 		   -- Date de début de l'épisode
	date_fin CHARACTER(5), 		   -- Date de fin de l'épisode
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_ft)
);

CREATE TABLE familial_event (    
	ref_ft SERIAL, 			 --
	personne CHARACTER(5),			--
	type_event CHARACTER(20),   --
	nb_children CHARACTER(2),
	rang CHARACTER(2),			  --
	annee CHARACTER(5),	 --
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),				  --
	PRIMARY KEY (ref_ft)
);


---------------------------------------------------
-- Création des tables "voyages"
---------------------------------------------------

CREATE TABLE leisure_trajectory (
	ref_lt SERIAL,
	personne CHARACTER (5) REFERENCES personne(id),
	PRIMARY KEY (ref_lt,personne),
	FOREIGN KEY (ref_lt) REFERENCES leisure_episode(ref_lt),
	FOREIGN KEY (ref_lt) REFERENCES leisure_event(ref_lt)
);

CREATE TABLE leisure_episode (
    ref_lt SERIAL,
	personne CHARACTER(5),			--
	type_episode CHARACTER(20),          -- 
	rang CHARACTER(2),
	date_debut CHARACTER(5), 		   -- Date de début de l'épisode
	date_fin CHARACTER(5), 		   -- Date de fin de l'épisode
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_lt)
);

CREATE TABLE leisure_event (
	ref_lt SERIAL,
	personne CHARACTER(5),			--
	rang CHARACTER(2),
	type_event CHARACTER(20),          -- Le type d'événement
    annee CHARACTER(5),           -- L'année de l'événement
	commune CHARACTER(50),
	ref_loc bigint REFERENCES localisation (ref_loc),
	PRIMARY KEY (ref_lt)
);

