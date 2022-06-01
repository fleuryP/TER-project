<!-- Here we have all data for one person -->

<script>
import axios from "axios";
let info = "";
export default {
  props: { individual_id: String },
  data() {
    return {
      info: "",
    };
  },
  methods: {
    getData() {
      const res = axios
        .get("http://localhost:8000/data/" + this.individual_id)
        .then((response) => {
          this.info = response.data;
        });
    },
  },
};
</script>

<template>
  <div>
    <button @click="getData()">Execute</button>
  </div>
</template>

<style></style>
