class Mirage.Resource extends Mirage.Object

  constructor: (@id, @url) ->
    @loaded = false

  load: (cb) ->
    @loaded = true
    cb()

  unload: (cb) ->
    @loaded = false
    cb()