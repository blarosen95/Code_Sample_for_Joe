<template>
  <div id="app">
    <v-app>
      <Landlords/>
    </v-app>
  </div>
</template>

<script>
import Landlords from "./packs/components/Landlords";
import {eventBus} from "./packs/main";

export default {
  data: function () {
    return {
      // landlordsConditional: true,
      // roomsConditional: false,
    };
  },
  components: {
    Landlords,
    // Rooms: Rooms
  },
  created() {
    // var callout = this;
    // eventBus.$on('appEvent', function (value) {
    //   callout.landlordsConditional = false;
    //   callout.roomsConditional = true;
    // })
  },

  updated() {
    eventBus.$off('appEvent');
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
