import { createApp } from "vue";
import App from "./App.vue";
import checkboxVue from "./components/checkbox.vue";

const app = createApp(App);
app.component("checkboxVue", checkboxVue);
app.mount("#app");
