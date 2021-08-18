<template>
  <div id="app">
    <v-app>
      <p>{{ message }}</p> <!-- TODO: Wouldn't really want this in a production app, but in a template it does showcase putting returned variables into Vue template tags (the line below already showcases including a Vue component -->
      <user/>
    </v-app>
  </div>
</template>

<script>
import user from "./packs/components/user.vue";

export default {
  data: function () {
    return {
      message: "Welcome to the Application!" // TODO: This won't serve a purpose to be returned for once the previous todo is done in a prod env.
    };
  },
  components: {
    user: user
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
