class Mirage.Resource extends Mirage.Object

  @initialize ->
    @loaded = false

  load: (cb) ->
    @loaded = true
    cb()

  unload: (cb) ->
    @loaded = false
    cb()