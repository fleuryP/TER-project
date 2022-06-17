<script setup>
import GroupItem from "./GroupItem.vue";
import IndividualItem from "./IndividualItem.vue";
import MetaItem from "./MetaItem.vue";
import HomeVue from "./Home.vue";

const page = "";
</script>

<template>
  <header>
    <div id="header">
      <button v-on:click="" class="navbar-toggler">STLife</button>
      <button v-on:click="" class="navbar-toggler">Home</button>
      <button v-on:click="" class="navbar-toggler">Individual</button>
      <button v-on:click="" class="navbar-toggler">Group</button>
      <button v-on:click="" class="navbar-toggler">Metadata</button>
      <button v-on:click="" class="navbar-toggler">?</button>
    </div>
  </header>
  <main><IndividualItem /></main>
</template>

<style scoped>
#header {
  background-color: rgb(50, 60, 84);
  width: 100%;
  padding: 10px;
  margin: 0 auto;
}
button {
  font-size: 30px;
  font-weight: bold;
  color: white;
  margin: 10px 0;
  padding: 10px;
  width: 16.33%;
}
</style>
