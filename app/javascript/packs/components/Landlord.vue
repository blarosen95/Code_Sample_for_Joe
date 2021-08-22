<template>
  <v-dialog v-model="dialog" max-height="90%" max-width="750px">
    <v-data-table :items-per-page="7" :headers="headers" :items="rooms" class="elevation-1">
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title>{{ landlord_name }}</v-toolbar-title>
        </v-toolbar>
      </template>
    </v-data-table>
  </v-dialog>
</template>

<script>
import {eventBus} from "../main";
import axios from "axios";

export default {
  name: "Landlord",
  data() {
    return {
      dialog: false,
      mainModality: false,
      landlord_name: "",
      rooms: [],
      headers: [
        {text: "Property Number", value: "id"},
        {text: "Property Name (if applicable)", value: "property_name"},
        {text: "Property Address", value: "property_address"},
        {text: "Tenants Potential", value: "tenants_max"},
        {text: "Tenants Actualized", value: "tenants_present"},
        {text: "Is Listed", value: "listed"},
        {text: "Pets Allowed", value: "restriction_pets"},
        {text: "Couples Allowed", value: "restriction_couples"}
      ],

    };
  },

  created() {
    var callout = this;
    eventBus.$on(`landlordSerial`, function (value) {
      console.log("Landlord.vue eventBus is on!");
      callout.mainModality = true;
      callout.landlord_name = value[0];
      axios.get(`http://127.0.0.1:3000/rooms/${value[1]}/index_by_landlord`)
          .then(response => {
            callout.rooms = response.data
            console.log(response.data)
          })
          .catch(e => {
            console.log(e);
          });
      callout.initialize(value[1]);
    })
  },

  methods: {
    initialize(id) {
      this.dialog = true;
      return axios.get(`http://127.0.0.1:3000/rooms/${id}/index_by_landlord`)
      .then(response => {
        this.rooms = response.data
      })
      .catch(e => {
        console.log(e);
      });
    },

    open(landlordSerial) {
      this.landlord_name = landlordSerial[0];
      this.initialize(landlordSerial[1]);
    },

  },
};
</script>

<style scoped>

</style>

<!--
Feel free to ignore this; I'm not in sales and I'm not interviewing to
be a pitch-guy anyways. I'm mostly including this so that I can reference it to propose a quarterly project at some
point down the road if I'm hired.

Breadcrumbs of information such as realized and potential tenancy can be leveraged outside of just SplitSpot's own
Business Intelligence use cases. I actually asked my mother, who has been renting vacation properties for quite a
while now, "what would push a platform like VRBO beyond the competition in terms of premium features?".

Ultimately, what's lacking is in-house analytics made available to users.

There's no doubting that these sorts of platforms utilize RUM analytics to help in their sales and marketing departments.
RUM can be done at scale on-prem for pretty much just the inherent costs of on-prem operations
(i.e. Servers, Co-Lo fees, etc.) alone, and it can easily be extended insofar as privately displaying the RUM results of
"premium" landlords' listings to them in a manner that's simple for the average landlord to digest and gain insight into
where they're reeling renters in and where they're losing them (i.e. bad photos, poor descriptions, or even the restrictions).

TL;DR:
Building on this concept of offering in-house BI to landlords to offset the overhead of SplitSpot's own analytics:
  * Carefully including these info-breadcrumbs at different levels of the stack can allow for premium users to know their competition.
    * Are they not realizing full tenancy due to restrictions?
      * Provide these users with correlations between quickly, fully realized tenancy for listings in the same region and restrictions on couples and/or pets.
        * In a college town, restrictions on couples is likely less of a deal breaker than those placed upon pets.
        Premium landlords/users could more accurately assess the trade-offs between TaT and pet cleaning fees if they were made aware that their competition is more successful when pets are allowed.

I'll leave it at that for now, something to consider at any point down the road. Likely best as a team than just me rambling.

-->