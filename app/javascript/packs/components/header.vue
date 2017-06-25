<template lang="pug">
  .grid-layout.navbar
    .left {{ logo }}
    .right
      el-dropdown(trigger="click", @command="performCommand")
        span.el-dropdown-link {{ $auth.name() }}
        el-dropdown-menu(slot="dropdown")
          el-dropdown-item(command="logout")
            icon(name="sign-out")
            span {{ $t("labels.Logout") }}
</template>

<script lang="coffee">
  export default {
    data: ->
      logo: "VueSample"
    methods:
      performCommand: (command) ->
        switch command
          when "logout"
            @logout()
      logout: ->
        @$auth.logout()
        @$router.push(name: "login")
  }
</script>

<style lang="sass" scoped>
  .navbar
    padding: 10px
</style>
