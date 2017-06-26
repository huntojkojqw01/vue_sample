import Rx from "rxjs/Rx"
import axios from "axios"
import Qs from "qs"
import { Notification } from "element-ui"

import Auth from "../plugins/auth"
import Engine from "../plugins/engine"

requests = 0

class Base
  @actions = {
    query:  { method: "GET",    path: "" }
    get:    { method: "GET",    path: ":id" }
    create: { method: "POST",   path: "" }
    update: { method: "PATCH",  path: ":id" }
    delete: { method: "DELETE", path: ":id" }
  }

  @endpoint: ->
    Engine.apiEndpoint

  @query: (params = {}) ->
    @_request("query", params: params).map(
      (response) =>
        response.meta = response.data.meta
        response.data = (new @(elem) for elem in response.data.data)
        response
    )

  @get: (data) ->
    @_request("get", data: data).map(
      (response) =>
        response.data = new @(response.data.data)
        response
    )

  @create: (data) ->
    @_request("create", data: data)

  @update: (data) ->
    @_request("update", data: data)

  @delete: (data) ->
    @_request("delete", data: { id: data.id })

  @isLoading: ->
    requests > 0

  @_request: (action, options) ->
    @onRequest()
    Rx.Observable.fromPromise(axios(@_config(action, options)))
      .finally(@onCompleted)
      .catch(@onError)

  @_config: (action, options) ->
    params = options.params
    data   = options.data
    config = @actions[action]

    path = (config.path || "").replace(/:(\w+)/g, (_, match1) -> "#{data[match1]}")
    path = "/#{path}" if path

    Object.assign(
      {}
      method:           config.method
      url:              @_url(path)
      headers:          @_headers()
      params:           params
      paramsSerializer: (params) ->
        Qs.stringify(params, encode: false, arrayFormat: "brackets")
      data:             data
    )

  @_url: (path) ->
    "#{@endpoint()}/#{@type}#{path}"

  @_headers: ->
    headers = {}
    token = Auth.token()
    headers.Authorization = "Bearer #{token}" if token
    headers

  @onRequest: ->
    requests += 1

  @onError: (error) ->
    Notification.error(message: Engine.i18n.t("messages.system_error"))
    if error.response.status == 401
      Auth.logout()
    Observable.throw(error)

  @onCompleted: ->
    requests -= 1

  constructor: (attributes = {}) ->
    Object.assign(@, attributes)

  save: ->
    if @id
      @update()
    else
      @create()

  create: ->
    @constructor.create(@)

  update: ->
    @constructor.update(@)

  delete: ->
    @constructor.delete(@)

export default Base
