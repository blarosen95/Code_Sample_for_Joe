<template>
<chartist type="Line" :data="patientData" :options="patientOptions" >

</chartist>
</template>

<script>
export default {
  name: "Charted",
  data: () => ({
    patientData: {
      labels: ["A", "B", "C"],
      series: [[1, 3, 2]] // TODO: We will substitute with the pressures until we get a decent feel for Chartist in Vue
      // series: [[1, 3, 2], [4, 6, 5]]
      // So both of the above series objects work (but [1, 3, 2] would not work fyi)
      // series: [pressures]
    },
    patientOptions: {
      lineSmooth: false
    }
  }),
  methods: {

  }
}
</script>

<style scoped>

</style>