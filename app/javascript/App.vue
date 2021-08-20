<template>
  <div id="app">
    <v-app>
      <p>{{ message }}</p> <!-- TODO: Wouldn't really want this in a production app, but in a template it does showcase putting returned variables into Vue template tags (the line below already showcases including a Vue component -->
      <Patient/>
<!--      <Charted/>-->
    </v-app>
    <v-app>
      <Charted/>
    </v-app>
  </div>
</template>

<script>
// import user from "./packs/components/user.vue"; // TODO: Out with the old
import Patient from "./packs/components/Patient.vue";
import Charted from "./packs/components/Charted";

export default {
  data: function () {
    return {
      message: "Welcome to the Application!" // TODO: This won't serve a purpose to be returned for once the previous todo is done in a prod env.
    };
  },
  components: {
    Charted,
    // user: user // TODO: Out with the old.
    Patient: Patient
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
