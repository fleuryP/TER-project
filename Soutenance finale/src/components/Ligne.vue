<template>
  <div id="chart">
    <apexchart
      height="350"
      :options="chartOptions"
      :series="series"
    ></apexchart>
  </div>
</template>
<script>
/**
 * Les données suivantes sont écrites en brut pour le moment mais l'objectif est de les générer automatiquement
 */
export default {
  data() {
    return {
      series: [
        // Episode : test
        {
          name: "Familial episode", // pour la legende
          data: [
            // doit contenir tout les Episodes Familiaux
            {
              x: "Familial", // la trajectoire que ca concerne
              y: [
                /* On donne le 31/12 de l'annee de debut 
                                et le 1/1 de l'annee de fin */
                new Date(1912, 12, 31).getTime(),
                new Date(1946, 1, 1).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1946, 12, 31).getTime(),
                new Date(1947, 1, 1).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1947, 12, 31).getTime(),
                new Date(1948, 1, 1).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1948, 12, 31).getTime(),
                new Date(1950, 1, 1).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1950, 12, 31).getTime(),
                new Date(1957, 1, 1).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1957, 12, 31).getTime(),
                new Date(1961, 1, 1).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1961, 12, 31).getTime(),
                new Date(1962, 1, 1).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1962, 12, 31).getTime(),
                new Date(1981, 1, 1).getTime(),
              ],
            },
          ],
        },
        // Event : Naissance enfant
        {
          name: "Familial event",
          data: [
            {
              x: "Familial",
              y: [
                new Date(1912, 1, 1).getTime(),
                new Date(1912, 12, 31).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                /* On donne le 1/1 de l'annee de debut 
                                et le 12/31 de l'annee de fin 
                                Sinon rien ne s'affiche, la on mets 1an */
                new Date(1946, 1, 1).getTime(),
                new Date(1946, 12, 31).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1947, 1, 1).getTime(),
                new Date(1947, 12, 31).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1948, 1, 1).getTime(),
                new Date(1948, 12, 31).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1950, 1, 1).getTime(),
                new Date(1950, 12, 31).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1957, 1, 1).getTime(),
                new Date(1957, 12, 31).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1961, 1, 1).getTime(),
                new Date(1961, 12, 31).getTime(),
              ],
            },
            {
              x: "Familial",
              y: [
                new Date(1962, 1, 1).getTime(),
                new Date(1962, 12, 31).getTime(),
              ],
            },
          ],
        },
        // Episode : Logement
        {
          name: "Residential episode",
          data: [
            {
              x: "Residential",
              y: [
                new Date(1912, 12, 31).getTime(),
                new Date(1921, 2, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1922, 12, 31).getTime(),
                new Date(1923, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1924, 12, 31).getTime(),
                new Date(1924, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1925, 12, 31).getTime(),
                new Date(1925, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1926, 12, 31).getTime(),
                new Date(1927, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1928, 12, 31).getTime(),
                new Date(1930, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1931, 12, 31).getTime(),
                new Date(1931, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1932, 12, 31).getTime(),
                new Date(1932, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1933, 12, 31).getTime(),
                new Date(1933, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1934, 12, 31).getTime(),
                new Date(1938, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1939, 12, 31).getTime(),
                new Date(1939, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1941, 12, 31).getTime(),
                new Date(1941, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1941, 12, 31).getTime(),
                new Date(1943, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1944, 12, 31).getTime(),
                new Date(1945, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1946, 12, 31).getTime(),
                new Date(1946, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1946, 12, 31).getTime(),
                new Date(1964, 1, 1).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1965, 12, 31).getTime(),
                new Date(1980, 1, 1).getTime(),
              ],
            },
          ],
        },
        // Evenement : Demenagement
        {
          name: "Residential evenement",
          data: [
            {
              x: "Residential",
              y: [
                new Date(1912, 1, 1).getTime(),
                new Date(1912, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1922, 1, 1).getTime(),
                new Date(1922, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1924, 1, 1).getTime(),
                new Date(1924, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1925, 1, 1).getTime(),
                new Date(1925, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1926, 1, 1).getTime(),
                new Date(1926, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1928, 1, 1).getTime(),
                new Date(1928, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1931, 1, 1).getTime(),
                new Date(1931, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1932, 1, 1).getTime(),
                new Date(1932, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1933, 1, 1).getTime(),
                new Date(1933, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1934, 1, 1).getTime(),
                new Date(1934, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1939, 1, 1).getTime(),
                new Date(1939, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1941, 1, 1).getTime(),
                new Date(1941, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1941, 1, 1).getTime(),
                new Date(1941, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1944, 1, 1).getTime(),
                new Date(1944, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1946, 1, 1).getTime(),
                new Date(1946, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1946, 1, 1).getTime(),
                new Date(1946, 12, 31).getTime(),
              ],
            },
            {
              x: "Residential",
              y: [
                new Date(1965, 1, 1).getTime(),
                new Date(1965, 12, 31).getTime(),
              ],
            },
          ],
        },
        // Episode : Lieu de travail
        {
          name: "Professional Episode",
          data: [
            {
              x: "Professional",
              y: [
                new Date(1925, 12, 31).getTime(),
                new Date(1925, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1926, 12, 31).getTime(),
                new Date(1927, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1928, 12, 31).getTime(),
                new Date(1929, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1930, 12, 31).getTime(),
                new Date(1930, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1931, 12, 31).getTime(),
                new Date(1931, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1932, 12, 31).getTime(),
                new Date(1932, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1934, 12, 31).getTime(),
                new Date(1938, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1941, 12, 31).getTime(),
                new Date(1941, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1941, 12, 31).getTime(),
                new Date(1943, 1, 1).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1944, 12, 31).getTime(),
                new Date(1970, 1, 1).getTime(),
              ],
            },
          ],
        },
        // Evenement : Changement d'emploi
        {
          name: "Professional event",
          data: [
            {
              x: "Professional",
              y: [
                new Date(1925, 1, 1).getTime(),
                new Date(1925, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1926, 1, 1).getTime(),
                new Date(1926, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1928, 1, 1).getTime(),
                new Date(1928, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1930, 1, 1).getTime(),
                new Date(1930, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1931, 1, 1).getTime(),
                new Date(1931, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1932, 1, 1).getTime(),
                new Date(1932, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1934, 1, 1).getTime(),
                new Date(1934, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1941, 1, 1).getTime(),
                new Date(1941, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1941, 1, 1).getTime(),
                new Date(1941, 12, 31).getTime(),
              ],
            },
            {
              x: "Professional",
              y: [
                new Date(1944, 1, 1).getTime(),
                new Date(1944, 12, 31).getTime(),
              ],
            },
          ],
        },
        // Episode : Voyage
        {
          name: "Leisure episode",
          data: [
            {
              x: "Leisure",
              y: [
                new Date(1980, 12, 31).getTime(),
                new Date(1980, 1, 1).getTime(),
              ],
            },
          ],
        },
        // Event : Voyage
        {
          name: "Leisure event",
          data: [
            {
              x: "Leisure",
              y: [
                new Date(1980, 1, 1).getTime(),
                new Date(1980, 12, 31).getTime(),
              ],
            },
          ],
        },
      ],
      chartOptions: {
        chart: {
          height: 350,
          type: "rangeBar",
        },
        plotOptions: {
          bar: {
            horizontal: true,
            barHeight: "50%",
            rangeBarGroupRows: true,
          },
        },
        colors: [
          /* On prend 2 couleurs pour chacun car episode et evenement  A MODIFIER */
          /* Familial en Rose (clair en premier pour les episodes et en foncé pour les evenements )*/
          "#ffcdd2",
          "#ff1744",
          /* Résidentiel en vert */
          "#ccff90",
          "#33691e",
          /* Professionnel en bleu */
          "#49b0ff",
          "#0663af",
          /* Voyage en jaune */
          "#fff176",
          "#f9a825",
        ],
        fill: {
          type: "solid",
        },
        xaxis: {
          type: "datetime", // ligne de temps
        },
        legend: {
          position: "right", // legende a droite
        },
        tooltip: {
          // pour retourner une etiquette lors du passage de la souris
          custom: function (opts) {
            const fromYear = new Date(opts.y1).getFullYear();
            const toYear = new Date(opts.y2).getFullYear();
            const values = opts.ctx.rangeBar.getTooltipValues(opts);
            const res = "Debut en " + fromYear + " et fin en " + toYear;
            return (
              // texte que l'on affiche lorsque l'on passe la souris
              res
            );
          },
        },
      },
    };
  },
};
</script>

<!-- Le scoped permet de n'appliquer le style qu'à cette page. -->
<style scoped>
.hori-timeline .events {
  border-top: 3px solid #e9ecef;
}

.hori-timeline .events .event-list {
  display: block;
  position: relative;
  text-align: center;
  padding-top: 70px;
  margin-right: 0;
}

.hori-timeline .events .event-list:before {
  content: "";
  position: absolute;
  height: 36px;
  border-right: 2px dashed #dee2e6;
  top: 0;
}

.hori-timeline .events .event-list .event-date {
  position: absolute;
  top: 38px;
  left: 0;
  right: 0;
  width: 75px;
  margin: 0 auto;
  border-radius: 4px;
  padding: 2px 4px;
}

@media (min-width: 1140px) {
  .hori-timeline .events .event-list {
    display: inline-block;
    width: 24%;
    padding-top: 45px;
  }

  .hori-timeline .events .event-list .event-date {
    top: -12px;
  }
}

.bg-soft-primary {
  background-color: rgba(64, 144, 203, 0.3) !important;
}

.bg-soft-success {
  background-color: rgba(71, 189, 154, 0.3) !important;
}

.bg-soft-danger {
  background-color: rgba(231, 76, 94, 0.3) !important;
}

.bg-soft-warning {
  background-color: rgba(249, 213, 112, 0.3) !important;
}

.card {
  border: none;
  margin-bottom: 24px;
  -webkit-box-shadow: 0 0 13px 0 rgba(236, 236, 241, 0.44);
  box-shadow: 0 0 13px 0 rgba(236, 236, 241, 0.44);
}

.map {
  height: 500px;
}
</style>
