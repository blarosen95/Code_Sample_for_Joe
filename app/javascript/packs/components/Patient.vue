<template>
  <v-data-table :items-per-page="5" :headers="headers" :items="dessert" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Patients</v-toolbar-title>
        <v-divider class="mx-4" inset vertical></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on: dialog }">
            <v-btn color="primary" dark class="mb-2" v-on="dialog">New Item</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model:append-icon="editedItem.first_name" label="First Name"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model:append-icon="editedItem.last_name" label="Last Name"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model:append-icon="editedItem.email" label="Email"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model:append-icon="editedItem.phone" label="Phone"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model:append-icon="editedItem.address" label="Address"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <input type="hidden" name="_token" v-bind:value="csrf" />
              <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
              <v-btn color="blue darken-1" text @click="save(editedItem)">Save</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>

    <template v-slot:item.action="{ item }">
      <v-icon small class="mr-2" @click="editItem(item)">edit</v-icon>
      <v-icon small @click="deleteItem(item)">delete</v-icon>
      <v-icon small @click="viewRecordDetails(item)">view details</v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>
  </v-data-table>
</template>

<script>
import axios from "axios";
export default {
  data: () => ({
    dialog: false,
    headers: [
      { text: "First Name", value: "first_name" },
      { text: "Last Name", value: "last_name" },
      { text: "Email", value: "email" },
      { text: "Phone", value: "phone" },
      { text: "Address", value: "address" },
      { text: "Actions", value: "action", sortable: false, align: "center" },
    ],
    dessert: [],
    // Assign the csrf token so that Axios stops using some cached/constant value instead.
    csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    editedIndex: -1,
    editedItem: {
      first_name: "",
      last_name: "",
      email: "",
      phone: "",
      address: ""
    },
    defaultItem: {
      name: "",
      calories: "",
      fat: "",
      carbs: "",
      protein: ""
    }
  }),
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    }
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },
  created() {
    this.initialize();
  },

  methods: {
    initialize() {
      return axios
      .get("http://localhost:3000/patients")
      .then(response => {
        this.dessert = response.data
      })
      .catch(e => {
        console.log(e);
      });
    },
    // Deprecated: TODO, get this outta here.
    getPatient(item) {
      axios.get(`http://localhost:3000/${item.id}`)
          .then(response => {
            this.dessert = response.data;
          })
          .catch(error => {
            console.log(error);
          })
    },

    editItem(item) {
      this.editedIndex = item.id;
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    deleteItem(item) {
      // FIXME: Might want some validation conditionals here but will leave out as they can be done in non-template uses
      // TODO: For now, having at least a confirmation dialog will help

      axios
      .delete(`http://127.0.0.1:3000/patients/${item.id}`, {
      headers: {'X-CSRF-TOKEN': this.csrf,}
      })
      .then(response => {
        console.log(response);
        this.initialize();
      })
      .catch(e => {
        console.log(e);
      });
    },

    save(item) {
      if (this.editedIndex > -1) {
        axios // The URL in use in the below call to put differs for an obvious CORS reason, normal prod app would see all URLS using the real application's URL
        .put(`http://127.0.0.1:3000/patients/${item.id}`, {
          id: this.editedItem.id,
          first_name: this.editedItem.first_name,
          last_name: this.editedItem.last_name,
          email: this.editedItem.email,
          phone: this.editedItem.phone,
          address: this.editedItem.address
        },
            {headers: {'X-CSRF-TOKEN': this.csrf,}}
        )
        .then(response => {
          console.log(response);
          this.initialize();
        })
        .catch(e => {
          console.log(e);
        });
      } else {
        axios.post('http://127.0.0.1:3000/patients/', {
          patient: this.editedItem
        },
            {headers: {'X-CSRF-TOKEN': this.csrf,}}
        )
        .then(response => {
          console.log(response);
          console.log("Created the new Patient."); // TODO: Neither this log statement nor the previous are needed in the end.
          this.initialize();
        })
        .catch(e => {
          console.log(e);
        });
      }
      this.close();
    },

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1;
      }, 300);
    }
  }
};
</script>
