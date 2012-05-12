class Mirage.ResourceManager
  resources: {}

  add: (resource) ->
    @resources[resource.id] = resource

  remove: (id) ->
    delete @resources[id]

  get: (id) ->
    @resources[id]

  load: (id, cb) ->
    @resources[id].load cb

  loadAll: (cb) ->
    loading = 0
    for id of @resources
      loading++
      @resources[id].load =>
        loading--
        if loading == 0
          cb()
