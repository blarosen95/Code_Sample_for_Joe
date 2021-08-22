<template>
  <v-dialog v-model="dialog" max-width="500px">
    <v-card>
      <v-card-title>
        <span class="headline">{{ diagTitle }}</span>
      </v-card-title>
      <v-card-text class="pa-4" v-show="!!message" v-html="message"></v-card-text>
      <v-card-actions class="pt-3">
        <v-spacer></v-spacer>
        <v-btn class="body-2 font-weight-bold" text color="grey" v-if="!options.noconfirm"
               @click.native="cancel">Cancel</v-btn>
        <v-btn class="body-2 font-weight-bold" outlined color="primary" @click.native="accept">Okay</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: "ConfirmationDialog",
  data() {
    return {
      dialog: false,
      resolve: null,
      reject: null,
      message: null,
      diagTitle: null,
      options: {
        color: "grey lighten-3",
        zIndex: 200,
        noconfirm: false,
      },
    };
  },

  methods: {
    open(diagTitle, message, options) {
      this.dialog = true;
      this.diagTitle = diagTitle;
      this.message = message;
      this.options = Object.assign(this.options, options);
      return new Promise((resolve, reject) => {
        this.resolve = resolve;
        this.reject = reject;
      });
    },
    accept() {
      this.resolve(true);
      this.dialog = false;
    },
    cancel() {
      this.resolve(false);
      this.dialog = false;
    },
  },
};
</script>

<style scoped>

</style>