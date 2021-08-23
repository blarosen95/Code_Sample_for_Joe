<template>
  <v-app-bar dark app>
    <div id="navbar" class="nav-flyout-button">
      <v-menu offset-x>
        <template v-slot:activator="{ on, attrs }">
          <v-btn dark v-bind="attrs" v-on:click="on">
            {{ "\f0c9" }}
          </v-btn>
        </template>
      </v-menu>
      <br/>
      <br/>
      <br/>
    </div>
  </v-app-bar>
</template>

<script>
export default {
  name: "NavBar",
}
</script>

<style scoped>

</style>