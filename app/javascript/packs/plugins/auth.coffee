class Auth
  constructor: ->
    @key = "auth"

  install: (@Vue, options) ->
    @router = options.router
    @Vue.prototype.$auth = @
    @router.beforeEach (to, from, next) =>
      if @_authorized(to)
        next()
      else
        next(name: "login")

  isLoggedIn: (type) ->
    @_auth()?.type == type

  login: (type, data) ->
    auth = JSON.stringify(type: type, token: data.jwt, name: data.name)
    localStorage.setItem(@key, auth)

  logout: ->
    localStorage.removeItem(@key)
    @router.push(name: "login")

  token: ->
    @_auth()?.token

  name: ->
    @_auth()?.name

  _auth: ->
    auth = localStorage.getItem(@key)
    auth && JSON.parse(auth)

  _authorized: (to) ->
    to.matched.every (route) =>
      auth = route.meta.auth
      return true unless auth
      @isLoggedIn(auth)

export default new Auth()
