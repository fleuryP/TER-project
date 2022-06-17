import checkboxVue from "./components/checkbox.vue";
import { createApp } from "vue";
import App from "./App.vue";
import store from "@/store.js";
import VueApexCharts from "vue3-apexcharts";

createApp(App)
  .use(store)
  .use(VueApexCharts)
  .component("checkboxVue", checkboxVue)
  .mount("#app");
