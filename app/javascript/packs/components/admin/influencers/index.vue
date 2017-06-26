<template lang="pug">
  .content
    h2 {{ $t("admin.influencers.list.title") }}

    el-form(:inline="true", label-width="120px")
      el-form-item(:label="$t('labels.Name')")
        el-input(v-model="queryParams.filter.name", autofocus)
      el-form-item(:label="$t('labels.EmailAddress')")
        el-input(v-model="queryParams.filter.email")
      el-form-item
        el-button(type="primary", native-type="submit", @click="query") {{ $t("labels.Search") }}

    el-button(@click="add") {{ $t("labels.Add") }}

    el-pagination(layout="sizes, prev, pager, next",
        :page-sizes="queryParams.pageSizes",
        :page-size="queryParams.page.size",
        :total="count",
        @size-change="changePageSize",
        @current-change="changePage")

    el-table(:data="influencers",
        v-loading.body="isLoading()",
        :default-sort = "{ prop: 'name', order: 'ascending' }",
        @selection-change="changeSelection",
        @sort-change="changeSort")

      el-table-column(type="selection", width="50")

      el-table-column(:label="$t('labels.Name')", prop="name", sortable)
        template(scope="scope")
          router-link(:to="{ name: 'edit influencer', params: { id: scope.row.id } }") {{ scope.row.name }}

      el-table-column(:label="$t('labels.EmailAddress')", prop="email", sortable)
        template(scope="scope")
          span {{ scope.row.email }}

      el-table-column(fixed="right", width="150")
        template(scope="scope")
          el-button(@click="edit(scope.row)", size="small") {{ $t("labels.Edit") }}
          el-button(@click="remove(scope.row)", type="danger", size="small") {{ $t("labels.Delete") }}

    el-pagination(layout="sizes, prev, pager, next",
        :page-sizes="queryParams.pageSizes",
        :page-size="queryParams.page.size",
        :total="count",
        @size-change="changePageSize",
        @current-change="changePage")
</template>

<script lang="coffee">
  import Influencer from "../../../resources/admin/influencer"
  import QueryParams from "../../../resources/query_params"

  export default {
    data: ->
      queryParams: new QueryParams()
      count:       0
      influencers: []
      selection:   []
    methods:
      query: (event = null) ->
        event?.preventDefault()
        Influencer.query(@queryParams.toQuery()).subscribe(
          (response) =>
            @count = response.meta.count
            @influencers = response.data
        )
      add: ->
        @$router.push(name: "new influencer")
      edit: (influencer) ->
        @$router.push(name: "edit influencer", params: { id: influencer.id })
      remove: (influencer) ->
        influencer.delete().subscribe(
          =>
            @$notify.success(message: @$i18n.t("messages.deleted"))
            @query()
        )
      changeSort: (sort) ->
        @queryParams.setSort(sort)
        @query()
      changePageSize: (size) ->
        @queryParams.changePageSize(size)
        @query()
      changePage: (page) ->
        @queryParams.changePage(page)
        @query()
#        @$router.push(path: @$route.path, query: @queryParams.toQuery())
      changeSelection: (value) ->
        @selection = value
      isLoading: ->
        Influencer.isLoading()
    mounted: ->
      @queryParams.update(@$route.query)
#      @query()
  }
</script>
