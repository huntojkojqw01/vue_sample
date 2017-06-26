import VueRouter from "vue-router/dist/vue-router.esm"
import Qs from "qs"

import Rx from "rxjs/Rx"
import VueRx from "vue-rx"

import VueI18n from "vue-i18n"

import ElementUI from "element-ui"
import elementEn from "element-ui/lib/locale/lang/en"
import elementJa from "element-ui/lib/locale/lang/ja"

import "vue-awesome/icons"
import Icon from "vue-awesome/components/Icon"

import Auth from "./auth"

class Engine
  install: (Vue, options) ->
    locale       = options.locale || "ja"
    @apiEndpoint = options.apiEndpoint || "http://localhost:3000/api"

    Vue.use(VueRouter)
    @router = new VueRouter(
      mode:   "history"
      base:   options.base || "/"
      routes: options.routes
      parseQuery: (query) ->
        Qs.parse(query)
      stringifyQuery: (query) ->
        result = Qs.stringify(query, encode: false)
        if result then "?#{result}" else ""
    )

    Vue.use(VueRx, Rx)

    Vue.use(VueI18n)

    messages = Object.assign(
      require("../locales/en.yml")
      require("../locales/ja.yml")
    )
    Object.assign(messages.en, elementEn)
    Object.assign(messages.ja, elementJa)
    @i18n = new VueI18n(locale: locale, messages: messages)

    Vue.use(ElementUI, i18n: (key) => @i18n.t(key))

    Vue.component("icon", Icon)

    Vue.use(Auth, router: @router)

export default new Engine()
