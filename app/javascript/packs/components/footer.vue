<template lang="pug">
  .grid-layout.footer
    .body.hcenter {{ footer }}
</template>

<script lang="coffee">
  export default {
    data: ->
      footer: "footer"
  }
</script>

<style lang="sass" scoped>
  .footer
    padding: 10px
    background-color: #eef1f6
</style>
