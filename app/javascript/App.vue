<template>
  <div id="app">
    <v-app>
      <p>{{ message }}</p> <!-- TODO: Wouldn't really want this in a production app, but in a template it does showcase putting returned variables into Vue template tags (the line below already showcases including a Vue component -->
      <Landlords/>
    </v-app>
<!--    <v-app>-->
<!--      <Charted/>-->
<!--    </v-app>-->
    <!-- TODO: ChartistJS irrelevant here and also bloating the project. ~200-400ms less response time non-compile -->
    <v-app>
      <Landlord/>
    </v-app>
  </div>
</template>

<script>
import Landlords from "./packs/components/Landlords";
import Charted from "./packs/components/Charted";
import Landlord from "./packs/components/Landlord";

export default {
  data: function () {
    return {
      message: "Welcome to the Application!" // TODO: This won't serve a purpose to be returned for once the previous todo is done in a prod env.
    };
  },
  components: {
    Landlord,
    Landlords,
    Charted,
    // Rooms: Rooms
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
