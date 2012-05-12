class Mirage.Scene extends Mirage.Object

  actors: {}

  constructor: (@id) ->

  addActor: (object) ->
    @actors[object.id] = object

  removeActor: (id) ->
    delete @actors[object.id]

  getActor: (id) ->
    @actors[id]

  render: ->
    actor.render?() for actor in @actors

  action: (deltaTime) ->
    actor.action?(deltaTime) for actor in @actors