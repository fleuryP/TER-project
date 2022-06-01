<script setup>
import GroupItem from "./GroupItem.vue";
import IndividualItem from "./IndividualItem.vue";
import MetaItem from "./MetaItem.vue";

const page = "";
</script>

<template>
  <header>
    <div id="header" class="btn-group" style="width: 100%">
      <button
        v-on:click="page = 'IndividualItem'"
        id="individual_window"
        style="width: 25%"
      >
        Individu
      </button>
      <button
        v-on:click="page = 'GroupItem'"
        id="group_window"
        style="width: 25%"
      >
        Groupe
      </button>
      <button
        v-on:click="page = 'MetaItem'"
        id="meta_window"
        style="width: 25%"
      >
        Meta-données
      </button>
      <button v-on:click="" id="?_window" style="width: 25%">?</button>
    </div>
  </header>
  <main><IndividualItem /></main>
</template>

<style>
.btn-group button {
  background-color: #04aa6d; /* Green background */
  border: 1px solid green; /* Green border */
  color: white; /* White text */
  padding: 10px 24px; /* Some padding */
  cursor: pointer; /* Pointer/hand icon */
  float: left; /* Float the buttons side by side */
}

.btn-group button:not(:last-child) {
  border-right: none; /* Prevent double borders */
}

/* Clear floats (clearfix hack) */
.btn-group:after {
  content: "";
  clear: both;
  display: table;
}

/* Add a background color on hover */
.btn-group button:hover {
  background-color: #3e8e41;
}
</style>
