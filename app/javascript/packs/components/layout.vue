<template lang="pug">
  .grid-layout.root
    .header
      router-view(name="header")
    .body
      router-view
    .footer
      router-view(name="footer")
</template>

<style src="element-ui/lib/theme-default/index.css"></style>
<style lang="sass" src="../assets/stylesheets/application.sass"></style>
