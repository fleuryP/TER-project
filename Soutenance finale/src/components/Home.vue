<template>
  <div class="container py-5">
    <div
      id="carouselExampleControls"
      class="carousel slide col-12 bg-dark mb-5 overflow-hidden"
      data-bs-ride="carousel"
      style="height: 645px"
    >
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img
            class="d-block w-100"
            src="../assets/images/5.jpg"
            style="object-fit: cover"
            alt=""
          />
        </div>
        <div class="carousel-item">
          <img
            class="d-block w-100"
            src="../assets/images/6.jpeg"
            style="object-fit: cover"
            alt=""
          />
        </div>
        <div class="carousel-item">
          <img
            class="d-block w-100"
            src="../assets/images/4.jpg"
            style="object-fit: cover"
            alt=""
          />
        </div>
      </div>
      <button
        class="carousel-control-prev"
        type="button"
        data-bs-target="#carouselExampleControls"
        data-bs-slide="prev"
      >
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button
        class="carousel-control-next"
        type="button"
        data-bs-target="#carouselExampleControls"
        data-bs-slide="next"
      >
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>

    <div class="row">
      <div class="col-8">
        <div class="bg-light p-3 px-4" style="">
          <h1
            class="color-dark d-inline-block mb-0"
            style="font-family: Verdana; font-size: 60px"
          >
            ST
          </h1>
          <span
            class="color-gray display-inline-block"
            style="font-size: 32px; margin-left: -15px; font-family: Verdana"
            >life</span
          >
          <p
            class="text"
            style="
              font-family: verdana;
              color: grey;
              font-size: 20px;
              line-height: 40px;
              margin-right: 5%;
            "
          >
            Our project is based on a study that was carried out in 1981 by the
            National Institute for Demographic Studies (INED). It is a
            questionnaire called "3B questionnaire" for 3 biographies, indeed we
            have the family, professional and migratory biography. This
            questionnaire was carried out on a population aged 45 to 69 years.
            the file provided to us contains 10 columns and 493856 lines...
            <button
              type="button"
              class="btn btn-dark"
              style="font-size: 20px; margin-left: 10px; margin-top: 5px"
            >
              Read More
            </button>
          </p>
        </div>
      </div>
      <div class="col-4">
        <div class="row p-2 py-3 bg-light mb-3">
          <div class="col-4 icon">
            <img
              class="logo w-100 d-block"
              style="object-fit: cover"
              src="../assets/images/logo.svg"
              alt=""
            />
          </div>
          <div class="col-8">
            <h4 class="title mb-3" style="font-size: 16px">About INED</h4>
            <hr />
            <p class="text" style="font-size: 14px">
              The National Institute for Demographic Studies (INED) is a public
              research organization specialized in the study of populations, a
              partner of the academic world and research at national and
              international level.
            </p>
          </div>
        </div>
        <div class="row p-2 py-3 bg-light">
          <div class="col-4 icon">
            <img
              class="logo w-100 d-block"
              style="object-fit: cover"
              src="../assets/images/Imag.jpeg"
              alt=""
            />
          </div>
          <div class="col-8">
            <h4 class="title mb-3" style="font-size: 16px">IMAG</h4>
            <hr />
            <p class="text" style="font-size: 14px">
              The IMAG building's strategy is to concentrate resources and
              skills to create a critical mass (800 teacher-researchers,
              researchers and doctoral students), increase synergies and
              guarantee Grenoble visibility on a global scale.
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer -->
  <footer class="bg-dark text-center text-white">
    <!-- Grid container -->
    <div class="container p-4">
      <!-- Section: Social media -->
      <section class="mb-4">
        <!-- Facebook -->
        <a
          class="btn btn-outline-light btn-floating m-1"
          href="#!"
          role="button"
          ><i class="fab fa-facebook-f"></i
        ></a>

        <!-- Twitter -->
        <a
          class="btn btn-outline-light btn-floating m-1"
          href="#!"
          role="button"
          ><i class="fab fa-twitter"></i
        ></a>

        <!-- Google -->
        <a
          class="btn btn-outline-light btn-floating m-1"
          href="#!"
          role="button"
          ><i class="fab fa-google"></i
        ></a>

        <!-- Instagram -->
        <a
          class="btn btn-outline-light btn-floating m-1"
          href="#!"
          role="button"
          ><i class="fab fa-instagram"></i
        ></a>

        <!-- Linkedin -->
        <a
          class="btn btn-outline-light btn-floating m-1"
          href="#!"
          role="button"
          ><i class="fab fa-linkedin-in"></i
        ></a>

        <!-- Github -->
        <a
          class="btn btn-outline-light btn-floating m-1"
          href="#!"
          role="button"
          ><i class="fab fa-github"></i
        ></a>
      </section>
      <!-- Section: Social media -->

      <!-- Section: Form -->
      <section class="">
        <form action="">
          <!--Grid row-->
          <div class="row d-flex justify-content-center">
            <!--Grid column-->
          </div>
          <!--Grid row-->
        </form>
      </section>
      <!-- Section: Form -->

      <!-- Section: Text -->
      <section class="mb-4">
        <p>
          Bâtiment IMAG - Université Grenoble Alpes - 700 avenue Centrale -
          Domaine Universitaire 38401 St Martin d'Hères - France Tel accueil :
          +33 (0)4 57 42 18 80 Email : accueil-batimag@univ-grenoble-alpes.fr
        </p>
      </section>
    </div>

    <!-- Copyright -->
    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
      © 2022 Copyright:Celia,Pierre,Maxime and Salwa
    </div>
    <!-- Copyright -->
  </footer>
  <!-- Footer -->
</template>

<script>
export default {
  name: "IndexComponent",
  data() {
    return {};
  },
};
</script>
