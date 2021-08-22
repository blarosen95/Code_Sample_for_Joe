<template>
  <v-data-table v-if="mainModality" :items-per-page="5" :headers="headers" :items="rooms" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>{{ landlord_name }}</v-toolbar-title>
      </v-toolbar>
    </template>
  </v-data-table>
</template>

<script>
import {eventBus} from "../main";
import axios from "axios";

export default {
  name: "Landlord",
  data() {
    return {
      mainModality: false,
      landlord_name: "",
      rooms: [],
      headers: [
        { text: "Property Number", value: "id" },
        { text: "Property Name (if applicable)", value: "property_name" },
        { text: "Property Address", value: "property_address" },
        { text: "Tenants Potential", value: "tenants_max" },
        { text: "Tenants Actualized", value: "tenants_present" },
        { text: "Is Listed", value: "listed" }, // This has some interesting potential as a feature; see next lines.
          // My thoughts here are that a room/property should be delisted once the potential tenancy is actualized.
          // At the same time, a landlord would obviously be happier if they did not have to relist when vacancies occur.
          // I'm sure that the current state of SplitSpot at least incorporates a similar mechanic already but there's
          // a lot of scalability here. I don't like asides in comments and this is already TL;DR; see the end for more.
        { text: "Pets Allowed", value: "restriction_pets" },
        { text: "Couples Allowed", value: "restriction_couples" }
      ],

    };
  },

  created() {
    var callout = this;
    eventBus.$on(`landlordSerial`, function (value) {
      console.log("Landlord.vue eventBus is on!");
      callout.mainModality = true;
      callout.landlord_name = value[0];
      // TODO: Finish implementing as started below (Actually, do this in init)
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
      return axios.get(`http://127.0.0.1:3000/rooms/${id}/index_by_landlord`)
    },

    open(landlordSerial) {
      this.mainModality = true;
    },

  },
};
</script>

<style scoped>

</style>

<!--
Alright, this might wind up being a lot of text. If so, feel free to ignore it; I'm not in sales and I'm not interviewing to
be a pitch-guy anyways. I'm mostly including this so that I can reference it to propose a quarterly project at some point down the road if I were to be hired.

Breadcrumbs of information such as realized and potential tenancy can be leveraged outside of just SplitSpot's own
Business Intelligence use cases. I actually asked my mother, who has been renting vacation properties
(ala https://www.fripptrip.com/ alongside vacation rental platforms such as VRBO and toolkits like OwnerRez) for quite a
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