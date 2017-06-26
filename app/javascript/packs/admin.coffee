import Vue from "vue/dist/vue.esm"

import Engine from "./plugins/engine"
import Layout from "./components/layout"
import routes from "./components/admin/routes"

Vue.use(Engine, base: "admin", routes: routes)

new Vue(
  el:         "#app"
  template:   "<Layout/>"
  components: { Layout }
  router:     Engine.router
  i18n:       Engine.i18n
)
