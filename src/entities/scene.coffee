class Mirage.Scene extends Mirage.Object

  constructor: ->
    @actors = {}
    super

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
    for id, actor of @actors
      actor.preAction?(deltaTime)
      actor.action?(deltaTime)

