---------------------------------------------------
-- Script postgre création tables

-- BENJAOUR Salwa
-- FLEURY Pierre
-- JORDAN Célia
---------------------------------------------------




---------------------------------------------------
-- Création de la table "personne"
---------------------------------------------------

CREATE TABLE personne (
    id	                   DOUBLE PRECISION PRIMARY KEY UNIQUE NOT NULL,       -- identifiant de la personne
    annee_naissance        CHARACTER(10) NOT NULL,          -- annee de naissance
    lieu_naissance         CHARACTER(60) UNIQUE NOT NULL,          -- lieu de naissance
    type                   CHARACTER(20) UNIQUE NOT NULL,          -- type de l'evenement
    rang                   DOUBLE PRECISION UNIQUE NOT NULL,       -- rang de l'evenement
    nombre_mariage         CHARACTER(10) UNIQUE,          -- valeur maximale du rang et de Mar dans 3B
    annee_deces            CHARACTER(10) UNIQUE,          -- 
    residential_trajectory CHARACTER(10) UNIQUE,             -- 
    professionnal_trajectory CHARACTER(10) UNIQUE,           -- 
    familial_trajectory    CHARACTER(10) UNIQUE,             -- 
    leisure_trajectory     CHARACTER(10) UNIQUE            -- 
);


---------------------------------------------------
-- Création des tables "résidentielles"
---------------------------------------------------

CREATE TABLE residential_trajectory (
    event                  CHARACTER(10),           -- 
    episode                CHARACTER(10)           -- 
);

CREATE TABLE residential_episode (
    type_residence        CHARACTER(20),           -- 
    rank                  CHARACTER(10),           -- 
    period                date           -- 
);

CREATE TABLE residential_event (
    type                  CHARACTER(10),           -- 
    year                  CHARACTER(10)           -- 
);


---------------------------------------------------
-- Création des tables "professionnelles"
---------------------------------------------------

CREATE TABLE professionnal_trajectory (
    event                  CHARACTER(10),           -- 
    episode                CHARACTER(10)           -- 
);

CREATE TABLE professionnal_episode (
    type                CHARACTER(10),           -- 
    rank                CHARACTER(10)           -- 
);

CREATE TABLE professionnal_event (
    type                CHARACTER(10)           -- 
);


---------------------------------------------------
-- Création des tables "familiales"
---------------------------------------------------

CREATE TABLE familial_trajectory (
    event                  CHARACTER(10),           -- 
    episode                CHARACTER(10)           -- 
);

CREATE TABLE familial_episode (
    status                  CHARACTER(10),           -- 
    nb_children             CHARACTER(10)           -- 
);

CREATE TABLE familial_event (
    type            CHARACTER(20)          --
);


---------------------------------------------------
-- Création des tables "voyages"
---------------------------------------------------

CREATE TABLE leisure_trajectory (
    event                  CHARACTER(10),           -- 
    episode                CHARACTER(10)           -- 
);

CREATE TABLE leisure_episode (
    type       CHARACTER(20)           -- 
);

CREATE TABLE leisure_event (
    type       CHARACTER(20)           -- 
);

