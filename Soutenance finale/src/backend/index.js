const express = require("express");
const bodyParser = require("body-parser");
const db = require("./queries");
var cors = require("cors");
const app = express();
const port = 8000;

app.use(bodyParser.json());

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

//Ici middleware sans route, donc appliqué à toutes les requêtes pour implémenter CORS
app.use(cors());

//La route de base, ici pour tester le fonctionnement du serveur
app.get("/", (request, response) => {
  response.json({ info: "Bien connecté au serveur" });
});

//Route de récupération des données d'une personne, via l'id passé en paramètre
app.get("/data/:id", db.getData);

app.listen(port, () => {
  console.log(`App running on port ${port}.`);
});
