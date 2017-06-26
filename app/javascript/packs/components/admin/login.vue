<template lang="pug">
  .grid-layout
    .body.center
      el-form(label-width="120px")
        el-form-item(:label="$t('labels.EmailAddress')")
          el-input(v-model="session.email", autofocus)
        el-form-item(:label="$t('labels.Password')")
          el-input(v-model="session.password", type="password")
        el-form-item
          el-button(type="primary", native-type="submit", @click="save") {{ $t("labels.Login") }}
</template>

<script lang="coffee">
  import Session from "../../resources/admin/session"

  export default {
    data: ->
      session: new Session()
    methods:
      save: (event) ->
        event.preventDefault()
        @session.create().subscribe(
          (response) =>
            @$auth.login("admin", response.data)
            @$notify.success(message: @$i18n.t("messages.logged_in"))
            @$router.push(name: "influencers")
        )
    mounted: ->
      @$router.push(name: "influencers") if @$auth.isLoggedIn("admin")
  }
</script>
