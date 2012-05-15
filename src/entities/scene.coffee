class Mirage.Scene extends Mirage.Object

  @initialize ->
    @actors = {}
    @x = 0
    @y = 0

  addActor: (actor) ->
    @actors[actor.id] = actor
    @

  removeActor: (id) ->
    delete @actors[object.id]
    @

  getActor: (id) ->
    @actors[id]

  setCameraPosition: (@x, @y) ->

  translateCamera: (dX, dY) ->
    @x += dX
    @y += dY

  render: ->
    actor.render?() for id, actor of @actors

  action: (deltaTime) ->
    for id, actor of @actors
      if actor.dead
        delete @actors[id]
      else
        actor.preAction?(deltaTime)
        actor.action?(deltaTime)

