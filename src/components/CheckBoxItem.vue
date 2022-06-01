<script setup>
import { ref } from "vue";
import Checkbox from "./checkbox.vue";
const props = defineProps(["items"]);
var show = true;

function showCheckboxes(parameter) {
  console.log(props);
  var checkboxes = document.getElementsByClassName("selector");
  console.log(props.items[parameter].ref);
  console.log(checkboxes[props.items[parameter].ref]);

  if (show) {
    checkboxes[props.items[parameter].ref].style.display = "block";
    show = false;
  } else {
    checkboxes[props.items[parameter].ref].style.display = "none";
    show = true;
  }
}
</script>

<template>
  <form>
    <div class="multipleSelection">
      <div class="selectBox" @click="showCheckboxes(0)">
        <select>
          <option>Select options</option>
        </select>
        <div class="overSelect"></div>
      </div>
      <div id="1" class="selector">
        <Checkbox
          v-for="item in items"
          :key="item.id"
          :fieldId="item.id"
          :label="item.message"
          :checked="true"
        >
          {{ item.message }}
        </Checkbox>
      </div>
    </div>
  </form>
</template>

<style>
h1 {
  color: green;
}

.multipleSelection {
  width: 300px;
  background-color: #bcc2c1;
}

.selectBox {
  position: relative;
}

.selectBox select {
  width: 100%;
  font-weight: bold;
}

.overSelect {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
}

.selector {
  display: none;
  border: 1px #8df5e4 solid;
}

.selector label {
  display: block;
}

#checkBoxes label:hover {
  background-color: #4f615e;
}
</style>
