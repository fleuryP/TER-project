<template>
  <!-- On affiche la map, elle prend 100% de la palce qui lui est laisser -->
  <div ref="map-root" style="width: 100%; height: 100%"></div>
</template>

<script>
/* Certains import son grisé car non utiliser pour le moment mais il seront utile plus tard */
import { transform } from "ol/proj.js";
import View from "ol/View";
import Map from "ol/Map";
import TileLayer from "ol/layer/Tile";
import OSM from "ol/source/OSM";
import Feature from "ol/Feature";
import Point from "ol/geom/Point";
import source_Vector from "ol/source/Vector";
import layer_Vector from "ol/layer/Vector";
import axios from "axios";
import { LineString, MultiPoint } from "ol/geom";

// On crée un point avec new Point([3.18099765766, 48.8218818253])
// var feature = new Feature({
//   geometry: new Point([3.18099765766, 48.8218818253])
// });

// On crée une ligne avec new LineString([[3.18099765766, 48.8218818253], [2.51078189836, 48.4743072486]])
// var feature = new Feature({
//     geometry: new LineString([[3.18099765766, 48.8218818253],
//   [2.51078189836, 48.4743072486]])
// });

// Pour plusieurs point MultiPoint -- Ici donc on affcihe deux point sur la Map
var feature = new Feature({
  geometry: new MultiPoint([
    [3.18099765766, 48.8218818253],
    [2.51078189836, 48.4743072486],
  ]),
});

// On mets sous la bonne forme les donnees.
feature.getGeometry().transform("EPSG:4326", "EPSG:3857");

export default {
  name: "MapContainer",
  components: {},
  props: { individual_id: String },
  data() {
    return {
      info: "",
    };
  },
  methods: {
    getData() {
      /* On fait un lien vers la base de donnée, plus tard il serait peut-être préférable de passer par le store pour cela */
      const res = axios
        .get("http://localhost:8000/data/" + 5000) //this.individual_id) // pour le moment 5000 juste pour le test.
        .then((response) => {
          this.info = response.data;
        });
    },
  },
  beforeMount() {
    this.getData();
  },
  mounted() {
    // const obj = JSON.parse(this.info);
    // this is where we create the OpenLayers map
    let map = new Map({
      // the map will be created using the 'map-root' ref
      target: this.$refs["map-root"],
      layers: [
        // adding a background tiled layer
        new TileLayer({
          source: new OSM(), // tiles are served by OpenStreetMap
        }),
        new layer_Vector({
          // Ajoute les points
          source: new source_Vector({
            features: [feature],
          }),
        }),

        //map.addLayer(vectorLayer)
      ],
      // the map view will initially show the whole world
      view: new View({
        zoom: 5,
        center: transform([2.5942188, 46.7132645], "EPSG:4326", "EPSG:3857"), // on centre sur la France
        constrainResolution: true,
      }),
    });
  },
};
</script>
