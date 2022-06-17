<script setup>
import Ligne from "./Ligne.vue";
import MapContainer from "./MapContainer.vue";
import axios from "axios";
import { ref, computed, reactive, watch } from "vue";

import CheckBoxItem from "./CheckBoxItem.vue";
import { useDataStore } from "../stores/DataStore";
import pinia from "@/store.js";

// Création et attribution d'une variable pour utiliser le store
const myUseStore = useDataStore(pinia);

const value1 = ref(true);
//Booléens utilisés pour afficher/cacher les blocs du menu
const affTempo = ref(true);
const affSpatial = ref(true);
const affFamilial = ref(true);
const affResi = ref(true);
const affPro = ref(true);
const affLeisure = ref(true);

//Variables utilisées pour gérer le filtre temporel
const year = ref("");
const period_first = ref("");
const period_second = ref("");

//Variables pour afficher les erreurs et bloquer les autres éléments pour éviter les problèmes
const anneeInvalide = ref(false); //Quand l'année n'est pas valide
const choixAnnee = ref(false); //Quand l'user entre une année précise

const choixPeriode = ref(false); //Quand l'user entre une période
const periodeInverse = ref(false); //Quand les bornes de la période sont inversées

/**
 * Watcher sur l'année, qui va envoyer une requête au serveur quand une date fixe valide est entrée
 * L'entrée d'une date va également bloquer la sélection sous forme de période
 */
watch(year, function callback(newYear, oldYear) {
  if (newYear.length >= 1) {
    //Tant que l'user entre quelque chose de non valide

    //On vient bloquer l'input des dates min et max
    choixAnnee.value = true;

    if (newYear > 1854 && newYear < 2000) {
      //Quand la date est valide pour les données
      //On place l'année dans les deux bornes pour n'avoir qu'une seule année sélectionnée dans le serveur
      myUseStore.dateMin = newYear;
      myUseStore.dateMax = newYear;

      anneeInvalide.value = false; //On enlève le message d'erreur
    }

    //Dans le cas où la date entrée juste avant était valide, et qu'elle est modifiée
    if (oldYear > 1854 && oldYear < 2000) {
      //On vient vider les bornes pour remettre à zéro la période
      myUseStore.dateMin = "";
      myUseStore.dateMax = "";

      anneeInvalide.value = true;
    }
  } else {
    //Quand il n'y a rien d'entré dans l'année, le choix de la période redevient possible
    choixAnnee.value = false;
  }
});

/**
 * Watcher sur les bornes de la période, qui va permettre de stocker les bornes, d'envoyer une erreur
 * et de bloquer la sélection par année précise
 */
watch([period_first, period_second], ([newPF, newPS], [oldPF, oldPS]) => {
  //Si l'user choisit d'entrer des dates dans la période, on entre ici
  if (newPF.length >= 1 || newPS.length >= 1) {
    //On bloque l'input de l'année
    choixPeriode.value = true;

    //Ici on vérifie que la borne supérieure n'est pas en dessous de la borne inférieure
    //Si c'est le cas, on affiche un message d'erreur
    if (parseInt(newPF, 10) > parseInt(newPS, 10)) {
      periodeInverse.value = true;
    } else {
      //La période est valide dans la logique
      periodeInverse.value = false;

      //Ici on va vérifier mtn que la période est valide dans ses valeurs
      if (newPF > 1854 && newPF < 2000 && newPS > 1854 && newPS < 2000) {
        //Quand les années sont bonnes, on les stocke dans le store
        myUseStore.dateMin = newPF;
        myUseStore.dateMax = newPS;

        anneeInvalide.value = false;
      }

      //Dans le cas où les années entrées juste avant étaient valide, et qu'elles sont modifiées
      if (oldPF > 1854 && oldPF < 2000 && oldPS > 1854 && oldPS < 2000) {
        //On vient vider les bornes pour remettre à zéro la période
        myUseStore.dateMin = "";
        myUseStore.dateMax = "";
      }
    }
  } else {
    choixPeriode.value = false;
    periodeInverse.value = false;
  }
});

/**
 *  Fonction de test du serveur : vérifie qu'aucune erreur n'existe en testant tous les identifiants
 */
function testServer() {
  for (let i = 5000; i <= 9904; i++) {
    axios.get("http://localhost:8000/data/" + i);
  }
}
</script>

<template>
  <main class="py-5" id="container">
    <div>
      <input
        v-model="myUseStore.individual_number"
        id="fillButton"
        type="text"
        placeholder="Individual number"
        aria-label="Search"
      />
      <button id="requestButton" @click="myUseStore.getData()">Search</button>
      <button id="requestButton" @click="value1 = !value1">
        {{ value1 ? "Hide request tool" : "Show request tool" }}
      </button>
      <br />
      <br />
    </div>
    <div id="general_bloc">
      <!-- composant principal divisé en 2 sous parties -->
      <div class="col-7" v-show="value1" id="first_bloc">
        <div class="card mb-5">
          <div
            class="card-header text-white bg-secondary mb-3 py-2 px-3"
            id="temporal_bloc"
          >
            <h5>Temporal trajectory</h5>
            <button @click="affTempo = !affTempo" class="menu_button">
              {{ affTempo ? "&#11165;" : "&#11167;" }}
            </button>
          </div>
          <div class="card-body pb-4" v-show="affTempo">
            <div class="info">
              <div v-if="anneeInvalide" class="validation">
                Les années doivent être comprises entre 1855 et 2000
              </div>
              <div v-if="periodeInverse" class="validation">
                L'année minimale doit être inférieure ou égale à l'année
                maximale
              </div>
            </div>

            <div class="row">
              <div class="row mb-4">
                <div class="col-md-6">
                  <div class="row">
                    <label
                      for="temporal"
                      class="form-label col-6 col-form-label text-end"
                      >Year</label
                    >
                    <div class="col-6">
                      <input
                        v-model="year"
                        id="year"
                        type="text"
                        class="form-control"
                        @focus="anneeInvalide = true"
                        @blur="anneeInvalide = false"
                        :disabled="choixPeriode"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <div class="row">
                    <label
                      for="temporal"
                      class="form-label col-7 col-form-label text-end"
                      >From</label
                    >
                    <div class="col-5">
                      <input
                        v-model="period_first"
                        id="period_first"
                        type="text"
                        class="form-control"
                        :disabled="choixAnnee"
                        @focus="anneeInvalide = true"
                        @blur="anneeInvalide = false"
                      />
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="row">
                    <label
                      for="temporal"
                      class="form-label col-7 col-form-label text-end"
                      >To</label
                    >
                    <div class="col-5">
                      <input
                        v-model="period_second"
                        id="period_second"
                        type="text"
                        class="form-control"
                        :disabled="choixAnnee"
                        @focus="anneeInvalide = true"
                        @blur="anneeInvalide = false"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="card mb-5">
          <div
            class="card-header text-white bg-secondary mb-3 py-2 px-3"
            id="spatial_bloc"
          >
            <h5>Spatial trajectory</h5>
            <button @click="affSpatial = !affSpatial" class="menu_button">
              {{ affSpatial ? "&#11165;" : "&#11167;" }}
            </button>
          </div>
          <div class="card-body pb-4" v-show="affSpatial">
            <div class="row">
              <div class="row mb-4">
                <!-- <div class="col-12">
                  <div class="row"> -->
                <label
                  for="country"
                  class="form-label col-5 col-form-label text-end"
                  >Country</label
                >
                <div class="col-7">
                  <CheckBoxItem
                    v-if="myUseStore.void_country_list"
                    :items="myUseStore.void_country_list"
                  />
                </div>
                <!-- </div>
                </div> -->
              </div>
              <div class="row mb-4">
                <!-- <div class="col-10">
                  <div class="row"> -->
                <label
                  for="departement"
                  class="form-label col-5 col-form-label text-end"
                  >Department</label
                >
                <div class="col-7">
                  <CheckBoxItem
                    v-if="myUseStore.void_departement_list"
                    :items="myUseStore.void_departement_list"
                  />
                </div>
                <!-- </div>
                </div> -->
              </div>
              <div class="row">
                <!-- <div class="col-10">
                  <div class="row"> -->
                <label
                  for="city"
                  class="form-label col-5 col-form-label text-end"
                  >City</label
                >
                <div class="col-7">
                  <CheckBoxItem
                    v-if="myUseStore.void_city_list"
                    :items="myUseStore.void_city_list"
                  />
                </div>
                <!-- </div>
                </div> -->
              </div>
            </div>
          </div>
        </div>

        <div class="card mb-5">
          <div
            class="card-header text-white bg-secondary mb-3 py-2 px-3"
            id="familial_bloc"
          >
            <h5>Familial trajectory</h5>
            <button @click="affFamilial = !affFamilial" class="menu_button">
              {{ affFamilial ? "&#11165;" : "&#11167;" }}
            </button>
          </div>
          <div class="card-body pb-4" v-show="affFamilial">
            <div class="row mb-5">
              <div class="row mb-4">
                <!-- <div class="col-10">
                  <div class="row"> -->
                <label
                  for="familial"
                  class="form-label col-7 col-form-label text-end"
                  >Number of parents</label
                >
                <div class="col-5">
                  <CheckBoxItem
                    v-if="myUseStore.void_number_of_parents"
                    :items="myUseStore.void_number_of_parents"
                  />
                  <!-- </div>
                  </div> -->
                </div>
              </div>
              <div class="row mb-4">
                <!-- <div class="col-10">
                  <div class="row"> -->
                <label
                  for="familial"
                  class="form-label col-7 col-form-label text-end"
                  >Number of children</label
                >
                <div class="col-5">
                  <CheckBoxItem
                    v-if="myUseStore.number_of_children"
                    :items="myUseStore.void_number_of_children"
                  />
                  <!-- </div>
                  </div> -->
                </div>
              </div>
              <div class="row">
                <!-- <div class="col-10">
                  <div class="row"> -->
                <label
                  for="familial"
                  class="form-label col-7 col-form-label text-end"
                  >Status</label
                >
                <div class="col-5">
                  <CheckBoxItem
                    v-if="myUseStore.void_status"
                    :items="myUseStore.void_status"
                  />
                </div>
                <!-- </div>
                </div> -->
              </div>
            </div>

            <div
              class="checkboxes d-flex justify-content-between mb-4"
              id="family_members"
            >
              <div class="col-4" style="width: calc(33.33% - 20px)" id="enfant">
                <h4>Children</h4>
                <div>
                  <input
                    id="birth_children"
                    type="checkbox"
                    name="birth_children"
                    checked
                  />
                  <label for="birth">Birth</label>
                </div>

                <div>
                  <input
                    id="work_children"
                    type="checkbox"
                    name="work_children"
                    checked
                  />
                  <label for="work">Work</label>
                </div>
                <div>
                  <input
                    type="checkbox"
                    id="res_children"
                    name="res_children"
                    checked
                  />
                  <label for="children_home">Home</label><br />
                </div>
                <div class="row mt-3">
                  <label
                    for="enfant"
                    class="form-label col-6 col-form-label text-end"
                  >
                    Rank
                  </label>
                  <div class="col-6">
                    <CheckBoxItem
                      v-if="myUseStore.void_number_of_children"
                      :items="myUseStore.void_number_of_children"
                    />
                  </div>

                  <br />
                </div>
              </div>
              <div
                class="col-4"
                style="width: calc(33.33% - 20px)"
                id="partner"
              >
                <h4>Partner</h4>
                <div>
                  <input
                    type="checkbox"
                    name="partner_birth"
                    id="partner_birth"
                    checked
                  />
                  <label for="partner_birth">Birth</label>
                </div>

                <div>
                  <input
                    type="checkbox"
                    id="partner_work"
                    name="partner_work"
                    checked
                  />
                  <label for="partner_work">Work</label>
                </div>
                <div>
                  <input
                    type="checkbox"
                    id="partner_home"
                    name="partner_home"
                    checked
                  />
                  <label for="partner_home">Home</label><br />
                </div>
              </div>
              <div class="col-4" style="width: calc(33.33% - 20px)" id="parent">
                <h4>Parents</h4>
                <div>
                  <input
                    type="checkbox"
                    id="birth_parent"
                    name="birth_parent"
                    checked
                  />
                  <label for="birth">Birth</label>
                </div>
                <div>
                  <input
                    type="checkbox"
                    id="work_parent"
                    name="work_parent"
                    checked
                  />
                  <label for="work">Work</label>
                </div>
                <div>
                  <input
                    type="checkbox"
                    id="parent_home"
                    name="parent_home"
                    checked
                  />
                  <label for="parent_home">Home</label><br />
                </div>
                <div>
                  <input
                    type="checkbox"
                    id="parent_death"
                    name="parent_death"
                    checked
                  />
                  <label for="parent_death">Death</label><br />
                </div>
                <div class="row mt-3">
                  <label
                    for="spatial"
                    class="form-label col-6 col-form-label text-end"
                  >
                    Rank
                  </label>
                  <div class="col-6">
                    <CheckBoxItem
                      v-if="myUseStore.void_number_of_parents"
                      :items="myUseStore.void_number_of_parents"
                    />
                  </div>
                  <br />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="card mb-5" id="residential_bloc">
          <div class="card-header text-white bg-secondary mb-3 py-2 px-3">
            <h5>Residential trajectory</h5>
            <button @click="affResi = !affResi" class="menu_button">
              {{ affResi ? "&#11165;" : "&#11167;" }}
            </button>
          </div>
          <div class="card-body pb-4" v-show="affResi">
            <div class="row">
              <div class="row mb-4">
                <div class="col-10">
                  <div class="row">
                    <label
                      for="residential"
                      class="form-label col-3 col-form-label text-end"
                      >Rank</label
                    >
                    <div class="col-9">
                      <CheckBoxItem
                        v-if="myUseStore.void_residential_commune"
                        :items="myUseStore.void_residential_commune"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="card mb-5" id="professionnal_bloc">
          <div class="card-header text-white bg-secondary mb-3 py-2 px-3">
            <h5>Professionnal trajectory</h5>
            <button @click="affPro = !affPro" class="menu_button">
              {{ affPro ? "&#11165;" : "&#11167;" }}
            </button>
          </div>
          <div class="card-body pb-4" v-show="affPro">
            <div class="row">
              <div class="row mb-4">
                <div class="col-10">
                  <div class="row">
                    <label
                      for="professionnal"
                      class="form-label col-3 col-form-label text-end"
                      >Activity</label
                    >
                    <div class="col-9">
                      <CheckBoxItem
                        v-if="myUseStore.void_activity"
                        :items="myUseStore.void_activity"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="row mb-4">
                <div class="col-10">
                  <div class="row">
                    <label
                      for="spatial"
                      class="form-label col-3 col-form-label text-end"
                      >Rank</label
                    >
                    <div class="col-9">
                      <CheckBoxItem
                        v-if="myUseStore.void_status"
                        :items="myUseStore.void_status"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-header text-white bg-secondary mb-3 py-2 px-3">
            <h5>Leisure trajectory</h5>
            <button @click="affLeisure = !affLeisure" class="menu_button">
              {{ affLeisure ? "&#11165;" : "&#11167;" }}
            </button>
          </div>
          <div class="card-body pb-4" v-show="affLeisure">
            <div class="row">
              <div class="row mb-4">
                <div class="col-10">
                  <div class="row">
                    <label
                      for="spatial"
                      class="form-label col-3 col-form-label text-end"
                      >Rank</label
                    >
                    <div class="col-9">
                      <CheckBoxItem
                        v-if="myUseStore.void_status"
                        :items="myUseStore.void_status"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="second_bloc">
        <!-- <div class="card mb-5"> -->
        <div class="card-header text-white bg-secondary mb-3 py-2 px-3">
          <h5>Localisation address</h5>
        </div>

        <div id="map_container">
          <MapContainer />
        </div>

        <br />
        <!-- </div> -->
        <div class="card">
          <div class="card-header text-white bg-secondary mb-3 py-2 px-3">
            <h5>
              Life trajectory of individual {{ myUseStore.individual_number }}
            </h5>
          </div>
          <!-- <Ligne /> -->
        </div>
      </div>
    </div>
  </main>
</template>

<style>
#container {
  margin-left: 10%;
  margin-right: 10%;
}
#fillButton {
  border-radius: 0.5rem;
  box-sizing: border-box;
  font-size: 16px;
  justify-content: center;
  padding: 1rem 1.75rem;
  margin-right: 5px;
}
#map_container {
  background-color: rgb(50, 60, 84);
  padding: 1%;
  border-radius: 2%;
  width: 100%;
  height: 100%;
}
#general_bloc {
  display: flex;
}
#first_bloc {
  width: 50%;
}
#requestButton {
  background-image: linear-gradient(-180deg, #37aee2 0%, #1e96c8 100%);
  border-radius: 0.5rem;
  box-sizing: border-box;
  color: #ffffff;
  font-size: 16px;
  justify-content: center;
  padding: 1rem 1.75rem;
  cursor: pointer;
  margin-right: 5px;
}

#second_bloc {
  margin-left: 5px;
  width: 100%;
  height: 500px;
}

label {
  display: inline-block;
  width: auto;
}

select {
  padding: 5px 10px;
}
.validation {
  border: 1px solid;
  margin: 10px 0px;
  padding: 15px 10px 15px 50px;
  background-repeat: no-repeat;
  background-position: 10px center;
}

.validation {
  color: #d63301;
  background-color: #ffccba;
  background-image: url("https://i.imgur.com/GnyDvKN.png");
}

.menu_button {
  float: right;
}
</style>
