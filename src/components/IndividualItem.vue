<script setup>
import MapContainer from "./MapContainer.vue";
import ListCreation from "./ListCreation.vue";
import { ref } from "vue";
import CheckBoxItem from "./CheckBoxItem.vue";
//const props = defineProps("list");
const individual_number = ref("");
const year = ref("");
const period_first = ref("");
const period_second = ref("");

const country_list = [
  { id: "1", message: "France", ref: "0" },
  { id: "2", message: "Angleterre", ref: "0" },
  { id: "3", message: "Espagne", ref: "0" },
  { id: "4", message: "Suisse", ref: "0" },
];

const departement_list = [
  { id: "1", message: "Isère", ref: "1" },
  { id: "2", message: "Eure", ref: "1" },
];

const city_list = [];

const number_parents_list = [
  { id: "1", message: "1", ref: "3" },
  { id: "2", message: "2", ref: "3" },
];
</script>

<template>
  <main>
    <ListCreation :individual_id="individual_number" />
    <input
      v-model="individual_number"
      id="individual_number"
      type="text"
      placeholder="Individual number"
    />
    <div id="general_bloc">
      <div id="first_bloc" class="part_bloc">
        <div id="temporal_bloc" class="bloc">
          <h3>Temporal trajectory</h3>
          <br />
          <label for="temporal"> year : </label
          ><input
            v-model="year"
            id="year"
            type="text"
            style="width: 50px"
          /><br />
          <label for="temporal"> period : </label
          ><input
            v-model="period_first"
            input
            id="period_first"
            type="text"
            style="width: 50px"
          /><label for="temporal"> to </label
          ><input
            v-model="period_second"
            id="period_second"
            type="text"
            style="width: 50px"
          />
        </div>
        <div id="spatial_bloc" class="bloc">
          <h3>Spatial trajectory</h3>
          <br />
          <label for="country"> Country </label>
          <CheckBoxItem :items="country_list" />
          <br />
          <label for="departement"> Departement </label
          ><CheckBoxItem :items="departement_list" /><br />
          <label for="city"> City </label>
          <CheckBoxItem :items="city_list" />
          <br />
        </div>
        <div id="familial_bloc" class="bloc">
          <h3>Familial trajectory</h3>
          <br />
          <label for="familial"> Number of parents </label
          ><CheckBoxItem :items="number_parents_list" /><br />
          <label for="familial"> Number of children </label
          ><CheckBoxItem :items="departement_list" /><br />
          <label for="familial"> status </label>
          <CheckBoxItem :items="departement_list" /><br />

          <div id="family_members">
            <div id="enfant" class="familial_specific_bloc">
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
                <label for="children_res">Res</label><br />
                <label for="enfant"> Rank </label>
                <CheckBoxItem :items="departement_list" /><br />
              </div>
            </div>
            <div id="parent" class="familial_specific_bloc">
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
                  id="res_parent"
                  name="res_parent"
                  checked
                />
                <label for="res">Res</label>
              </div>
              <label for="parent"> Rank </label>
              <CheckBoxItem :items="departement_list" /><br />
            </div>
            <div id="conjoint" class="familial_specific_bloc">
              <h4>Conjoint</h4>
              <div>
                <input
                  type="checkbox"
                  name="birth_cjt"
                  id="birth_cjt"
                  checked
                />
                <label for="scales">Birth</label>
              </div>

              <div>
                <input type="checkbox" id="work_cjt" name="work_cjt" checked />
                <label for="horns">Work</label>
              </div>
              <div>
                <input type="checkbox" id="res_cjt" name="res_cjt" checked />
                <label for="horns">Res</label>
              </div>
              <div>
                <label for="horns"></label>
              </div>
            </div>
          </div>
        </div>
        <div id="residential_bloc" class="bloc">
          <h3>Residential trajectory</h3>
          <br />
          <label for="residential"> Rank </label>
          <CheckBoxItem :items="departement_list" /><br />
        </div>
        <div id="professionnal_bloc" class="bloc">
          <h3>Professionnal trajectory</h3>
          <br />

          <label for="professionnal"> Activity </label
          ><CheckBoxItem :items="departement_list" /><br />
          <label for="spatial"> Rank </label>
          <CheckBoxItem :items="departement_list" /><br />
        </div>
        <div id="leisure_bloc" class="bloc">
          <h3>Leisure trajectory</h3>
          <br />
          <label for="spatial"> Rank </label>
          <CheckBoxItem :items="departement_list" /><br />
        </div>
      </div>

      <div id="second_bloc" class="part_bloc">
        <div id="map_container">
          <MapContainer />
        </div>
        <div>
          <h4>Lignes de vie de l'individu XXXX</h4>
          <br />
        </div>
      </div>
    </div>
  </main>
</template>

<style>
.bloc {
  background-color: rgb(168, 219, 148);
  height: auto;
  margin: 2px;
  padding: 10px 24px; /* Some padding */
  border: 2px solid rgb(39, 107, 39); /* Green border */
}
#general_bloc {
  display: flex;
}
#map_container {
  width: 100%;
  height: 100%;
  background-color: rgb(50, 84, 53);
  padding: 1%;
  border-radius: 2%;
}

main {
  margin-top: 2%;
}

label {
  display: inline-block;
  width: 110px;
}
select {
  padding: 5px 10px;
}
.familial_specific_bloc {
  display: inline-block;
}

.part_bloc {
  width: 600px;
  height: 600px;
  flex: 1;
  padding: 1em;
}
</style>
