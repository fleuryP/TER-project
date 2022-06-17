import { defineStore } from "pinia";
import axios from "axios";

export const useDataStore = defineStore("DataStore", {
  state: () => ({
    individual_number: "",
    info: "",
    answer: "",

    activity_list: "", // liste des activités
    city_list: "", // liste des villes
    country_list: "", // liste des pays
    departement_list: "", // liste des departements
    number_of_parents: "", // liste du nombre de parents
    number_of_children: "", // liste du nombre d'enfants
    status: "", //liste des status
    leisure_rank: "", // liste des rangs des voyages
    professionnal_rank: "", // liste des rangs des professions
    residential_commune: "", // liste des rangs des communes de résidence

    void_city_list: [], // liste des villes
    void_country_list: [], // liste des pays
    void_departement_list: [], // liste des departements
    void_number_of_parents: [], // liste du nombre de parents
    void_number_of_children: [], // liste du nombre d'enfants
    void_status: [], //liste des status
    void_leisure_rank: [], // liste des rangs des voyages
    void_professionnal_rank: [], // liste des rangs des professions
    void_residential_commune: [], // liste des rangs des communes de résidence
    void_activity: [], // liste des activités
  }),
  // getters
  getters: {
    //individual_number: (state) => state.individual_number,
  },
  // actions
  actions: {
    /**
     * Fonction qui permet de retirer les objets avec la valeur de `message` en double dans un tableau
     *
     * @param {*} originalArray
     * @param {*} prop
     * @return {*} un nouveau tableau sans les éléments en double
     */
    removeDuplicates(originalArray, prop) {
      var newArray = [];
      var lookupObject = {};

      for (var i in originalArray) {
        lookupObject[originalArray[i][prop]] = originalArray[i];
      }

      for (i in lookupObject) {
        newArray.push(lookupObject[i]);
      }
      console.log(newArray);
      console.log(lookupObject);
      return newArray;
    },
    /**
     * Fonction qui remplit un tableau avec une liste d'objets
     *
     * @param {*} list_to_fill
     * @param {*} list
     * @param {*} ref
     * @return {*} un tableau avec les objets listés
     */
    fill_list(list_to_fill, list, ref) {
      for (let i = 0; i < list.length; ++i) {
        let tab = {};
        tab["id"] = `${i + 1}`;
        tab["message"] = list[i];
        tab["ref"] = ref;
        list_to_fill.push(tab);
      }
      return this.removeDuplicates(list_to_fill, "message");
    },
    /**
     * Fonction qui récupère les valeurs d'un champs donné dans un tableau
     *
     * @param {*} input
     * @param {*} field
     * @return {*} un tableau avec les clé trouvés
     */
    getFields(input, field) {
      var output = [];
      for (var i = 0; i < input.length; ++i) output.push(input[i][field]);
      return output;
    },
    /**
     * Fonction qui récupère les informations relatives à un individu et les place dans
     * la varibalbe `info`
     */
    async getData() {
      await axios
        .get("http://localhost:8000/data/" + this.individual_number)
        .then((response) => {
          const info = response.data;
          this.info = info;

          // // Remplir la liste des pays habitées
          // const activity_answer = this.fetchFromObject(info, "pro");
          // this.activity_list = this.getFields(activity_answer, "activity");

          // Remplir la liste des pays habitées
          const country_answer = this.fetchFromObject(info, "residential");
          this.country_list = this.getFields(country_answer, "pays");

          // Remplir la liste des communes habitées
          const res_answer = this.fetchFromObject(info, "residential");
          this.residential_commune = this.getFields(res_answer, "commune");

          // Remplir la liste des departement pro
          let departement_answer = this.fetchFromObject(info, "pro");
          this.departement_list = this.getFields(
            departement_answer,
            "departement"
          );

          // Remplir la liste des rang pro
          const pro_answer = this.fetchFromObject(info, "pro");
          this.professionnal_rank = this.getFields(pro_answer, "rang");

          // Remplir la liste des rang de leisure
          const lei_answer = this.fetchFromObject(info, "leisure");
          this.leisure_rank = this.getFields(lei_answer, "rang");

          // Remplir la liste du nombre d'enfants
          const child_answer = this.fetchFromObject(info, "familial.children");
          this.number_of_children = this.getFields(child_answer, "rang");

          // Remplir la liste du nombre de parents
          const parents_answer = this.fetchFromObject(info, "familial.parents");
          this.number_of_parents = this.getFields(parents_answer, "rang");

          // // Remplir la liste des status
          // const status_answer = this.fetchFromObject(info, "familial.status");
          // this.status = this.getFields(status_answer, "status");
        });
      this.void_departement_list = this.fill_list(
        this.void_departement_list,
        this.departement_list,
        1
      );
      this.void_country_list = this.fill_list(
        this.void_country_list,
        this.country_list,
        2
      );
      this.void_number_of_parents = this.fill_list(
        this.void_number_of_parents,
        this.number_of_parents,
        3
      );
      this.void_number_of_children = this.fill_list(
        this.void_number_of_children,
        this.number_of_children,
        4
      );
      // this.fill_list(this.void_status, this.status, 5);
      this.void_leisure_rank = this.fill_list(
        this.void_leisure_rank,
        this.leisure_rank,
        6
      );
      this.void_professionnal_rank = this.fill_list(
        this.void_professionnal_rank,
        this.professionnal_rank,
        7
      );
      this.void_residential_commune = this.fill_list(
        this.void_residential_commune,
        this.residential_commune,
        8
      );
      // this.fill_list(this.void_activity, this.activity_list, 1);
      console.log(this.filled_list);
    },
    /**
     * Fonction
     *
     * @param {*} obj
     * @param {*} prop
     * @return {*} un objet
     */
    fetchFromObject(obj, prop) {
      if (typeof obj === "undefined") {
        return false;
      }

      var _index = prop.indexOf(".");
      if (_index > -1) {
        return this.fetchFromObject(
          obj[prop.substring(0, _index)],
          prop.substr(_index + 1)
        );
      }
      return obj[prop];
    },
  },
});
