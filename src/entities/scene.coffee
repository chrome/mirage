class Mirage.Scene extends Mirage.Object

  actors: {}

  addActor: (actor) ->
    @actors[actor.id] = actor
    @

  removeActor: (id) ->
    delete @actors[object.id]
    @

  getActor: (id) ->
    @actors[id]

  render: ->
    actor.render?() for id, actor of @actors

  action: (deltaTime) ->
    actor.action?(deltaTime) for id, actor of @actors