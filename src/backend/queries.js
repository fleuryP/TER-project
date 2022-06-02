const { response } = require("express");
const Pool = require("pg").Pool;

//Connexion à la db
const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "TER_db_3B",
  password: "admin",
  port: 5432,
});

let responseJSON = {}; //L'objet qu'on va alimenter avec les résultats des requêtes et renvoyer

/**
 * Fonction qui va aller récupérer les informations de la personne demandée,
 * et renvoyer une réponse sous forme de json contenant 4 objets avec les infos
 * dans les 4 dimensions principales
 *
 * @param {*} req requete recue, notamment avec l'id de la personne
 * @param {*} response réponse envoyée
 */
async function getData(req, response) {
  console.log("-------------------------------------------------------------");
  console.log("---------------ARRIVEE DANS LA FONCTION GETDATA--------------");
  console.log("-------------------------------------------------------------");

  let id = parseInt(req.params.id); //On récupère l'id de la personne dans la requete envoyée au serveur

  if (id < 5000 || id > 9904 || isNaN(id)) {
    console.log("User input invalide");
    response.status(400).json({
      error: "InvalidUserInput",
      message: "Identifiant entré invalide",
    });
  } else {
    //On attend la fin de chaque fonction requete pour tout bien récupérer avant de renvoyer la réponse
    await getResidential(id);
    await getFamilial(id);
    await getProfessional(id);
    await getLeisure(id);

    response.status(200).json(responseJSON); //On renvoie l'objet qu'on a construit avec les requetes

    console.log("--------------------------------------------");
    console.log("------------FIN DE LA REQUETE---------------");
    console.log("--------------------------------------------");
  }
}

/**
 * Renvoie un objet contenant toutes les informations résidentielles de la personne, et les place dans le JSON réponse avec l'id 'residential'
 *
 * @param {*} id le numéro de la personne dont on veut les infos
 */
async function getResidential(id) {
  console.log("On passe dans la fonction rési, id vaut : " + id);

  let requeteRes =
    "SELECT requete.*, latitude, longitude, pays FROM localisation, (SELECT fk_ref_loc as loc, 'habitat' as type_event, annee as annee FROM residential_event WHERE personne = $1 UNION SELECT fk_ref_loc as loc, 'etudes' as type_event, annee as annee FROM professionnal_event WHERE personne = $1 AND type_event='Etude' UNION SELECT fk_ref_loc as loc,  'naissance' as type_event, annee as annee FROM familial_event WHERE type_event='Naissance ego' AND personne = $1 ORDER by annee) as requete WHERE requete.loc = pk_ref_loc";

  //Appel de la fonction requete avec seulement un id principal
  await request(requeteRes, id, "residential", null);
}

/**
 * Renvoie un objet contenant les informations familiales de la personne (mariage, enfants, parents et conjoint)
 * L'objet est identifié par l'id "familial" et possède 4 sous-identifiants pour les 4 sous catégories
 *
 * @param {*} id le numéro de la personne
 */
async function getFamilial(id) {
  console.log("On passe dans la fonction familial, id vaut : " + id);

  responseJSON.familial = {}; //Initialisation de l'objet familial pour pouvoir lui donner des attributs

  //On fait une requete pour chaque sous-dimension du familial, ce qui va trier facilement et éviter les problèmes de rang similaires
  //Et faciliter le travail de traitement dans le frontend
  let requeteMariage =
    "SELECT requete.*, latitude, longitude, pays FROM localisation, (SELECT rang, annee, fk_ref_loc as loc FROM familial_event WHERE type_event='Mariage' AND personne = $1 ORDER BY annee) as requete WHERE requete.loc = pk_ref_loc";
  let requeteEnfants =
    "SELECT requete.*, latitude, longitude, pays FROM localisation, (SELECT rang, annee, type_lieu, fk_ref_loc as loc FROM enfant WHERE fk_personne_id = $1 ORDER BY annee) as requete WHERE requete.loc = pk_ref_loc";
  let requeteParents =
    "SELECT requete.*, latitude, longitude, pays FROM localisation, (SELECT rang, annee, type_lieu, fk_ref_loc as loc FROM parent WHERE fk_personne_id = $1 ORDER BY annee) as requete WHERE requete.loc = pk_ref_loc";
  let requeteConjoint =
    "SELECT requete.*, latitude, longitude, pays FROM localisation, (SELECT annee, type_lieu, fk_ref_loc as loc FROM conjoint WHERE fk_personne_id = $1 ORDER BY annee) as requete WHERE requete.loc = pk_ref_loc";

  //Appel de la fonction de requete pour chaque sous-objet de la dimension familiale, donc on passe également un idSecondaire (au lieu de null ailleurs)
  await request(requeteMariage, id, "familial", "mariage");
  await request(requeteEnfants, id, "familial", "children");
  await request(requeteParents, id, "familial", "parents");
  await request(requeteConjoint, id, "familial", "partner");
}

/** Fonction qui récupère les informations pro dans la db et les place dans l'objet json réponse, avec l'id 'pro'
 *
 * @param {*} id l'id de la personne demandée
 */
async function getProfessional(id) {
  console.log("On passe dans la fonction pro, id vaut : " + id);

  let requetePro =
    "SELECT requete.*, latitude, longitude, pays FROM localisation, (SELECT rang, date_debut, date_fin, fk_ref_loc as loc FROM professionnal_episode WHERE type_episode='Emploi' AND personne = $1 ORDER BY date_debut) as requete WHERE requete.loc = pk_ref_loc";

  //Appel de la fonction requete avec seulement un id principal
  await request(requetePro, id, "pro", null);
}

/** Récupère les informations des voyages d'une personne donnée et les place dans la réponse JSON avec l'id 'leisure'
 *
 * @param {*} id l'id de la personne demandée
 */
async function getLeisure(id) {
  console.log("On passe dans la fonction voyages, id vaut : " + id);
  let requeteLeisure =
    "SELECT requete.*, latitude, longitude, pays FROM localisation, (SELECT rang, date_debut, date_fin, type_episode, fk_ref_loc as loc FROM leisure_episode WHERE personne = $1 ORDER BY date_debut) as requete WHERE requete.loc = pk_ref_loc";

  //Appel de la fonction requete avec seulement un id principal
  await request(requeteLeisure, id, "leisure", null);
}

/**
 * Fonction de factorisation qui va effectuer la requete SQL auprès de la db, donc qu'on va appeler pour chaque requete dans les fonctions au-dessus
 *
 * @param {String} requete la requete postGre a envoyer à la db
 * @param {*} idPersonne l'id de la personne à passer dans la requete
 * @param {String} idPrincipalReponse id auquel on va mettre les données dans la réponse
 * @param {String} idSecondaireReponse si besoin l'id du sous objet (utile dans familial notamment)
 */
async function request(
  requete,
  idPersonne,
  idPrincipalReponse,
  idSecondaireReponse
) {
  let colonnes = (await pool.query(requete, [idPersonne])).rows; //On attend la fin de la requete et on met les rows dans une fonction

  if (idSecondaireReponse == null) {
    //Si on a seulement un id et pas de sous-id
    responseJSON[idPrincipalReponse] = colonnes; //On place ces colonnes dans l'objet avec seulement l'id
  } else {
    //Dans ce cas on doit placer les réponses avec le sous-id, l'id principal aura été initialisé avant
    responseJSON[idPrincipalReponse][idSecondaireReponse] = colonnes; //On place ces colonnes dans l'objet avec l'id principal + l'id secondaire
  }
}

//On exporte la fonction pour qu'elle soit utilisée dans l'index.js
module.exports = {
  getData,
};