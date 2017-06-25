class QueryParams
  constructor: (params = {}) ->
    @filter = {}
    @sort = {}
    @page =
      number: 1
      size:   20
    @pageSizes = [20, 50, 100]
    @update(params)

  update: (params) ->
    Object.assign(@filter, params.filter) if params.filter
    @setSort(params.sort)
    @changePage(params.page?.number)
    @changePageSize(params.page?.size)
    @

  setSort: (sort) ->
    return unless sort
    @sort.prop  = sort.prop
    @sort.order = sort.order

  changePage: (page) ->
    page = parseInt(page)
    @page.number = page if page

  changePageSize: (size) ->
    size = parseInt(size)
    @page.size = size if size

  toQuery: ->
    query = {}
    @_setFilterQuery(query)
    @_setSortQuery(query)
    query.page   = @page if @page
    query

  _setFilterQuery: (query) ->
    filters = null
    for field, filter of @filter when field && filter
      filters ||= {}
      filters[field] = filter
    query.filter = filters if filters

  _setSortQuery: (query) ->
    return unless @sort && @sort.prop && @sort.order
    order = if @sort.order == "ascending" then "" else "-"
    query.sort = "#{order}#{@sort.prop}"

export default QueryParams
