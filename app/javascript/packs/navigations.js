import Vue from 'vue'
import Vuetify from "vuetify"
import 'vuetify/dist/vuetify.min.css'
import Navigation from "../Navigation";

console.log("hello");

Vue.use(Vuetify)

// document.addEventListener('DomContentLoaded', () => {
    console.log("Listening");
    const nav = new Vue({
        vuetify: new Vuetify(),
        render: h => h(Navigation)
    }).$mount()
    document.body.appendChild(nav.$el)
// })