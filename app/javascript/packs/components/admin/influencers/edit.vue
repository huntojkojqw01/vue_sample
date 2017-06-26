<template lang="pug">
  .content
    h2 {{ $t("admin.influencers.edit.title") }}

    el-form(label-width="120px")
      el-form-item(:label="$t('labels.Name')")
        el-input(v-model="influencer.name", autofocus)
      el-form-item(:label="$t('labels.EmailAddress')")
        el-input(v-model="influencer.email")
      el-form-item
        el-button(type="primary", native-type="submit", @click="save") {{ $t("labels.Save") }}
</template>

<script lang="coffee">
  import Influencer from "../../../resources/admin/influencer"

  export default {
    data: ->
      influencer: new Influencer()
    methods:
      save: (event) ->
        event.preventDefault()
        @influencer.save().subscribe(
          (response) =>
            @$notify.success(message: @$i18n.t("messages.saved"))
            @$router.push(name: "influencers")
        )
    mounted: ->
      id = @$route.params.id
      return unless id
      Influencer.get(id: id).subscribe(
        (response) =>
          @influencer = response.data
      )
  }
</script>
