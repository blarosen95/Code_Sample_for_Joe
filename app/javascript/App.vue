<template>
  <div id="app">
    <v-app v-if="landlordsConditional">
<!--      <p>{{ message }}</p> &lt;!&ndash; TODO: Wouldn't really want this in a production app, but in a template it does showcase putting returned variables into Vue template tags (the line below already showcases including a Vue component &ndash;&gt;-->
      <Landlords/>
    </v-app>
<!--    <v-app>-->
<!--      <Charted/>-->
<!--    </v-app>-->
    <!-- TODO: ChartistJS irrelevant here and also bloating the project. ~200-400ms less response time non-compile -->
    <v-app v-if="roomsConditional">
      <Landlord/>
    </v-app>
  </div>
</template>

<script>
import Landlords from "./packs/components/Landlords";
import Charted from "./packs/components/Charted";
import Landlord from "./packs/components/Landlord";
import {eventBus} from "./packs/main";

export default {
  data: function () {
    return {
      landlordsConditional: true,
      roomsConditional: false,
    };
  },
  components: {
    Landlord,
    Landlords,
    Charted,
    // Rooms: Rooms
  },
  created() {
    var callout = this;
    eventBus.$on('appEvent', function (value) {
      callout.landlordsConditional = false;
      callout.roomsConditional = true;
    })
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
