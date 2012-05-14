class Mirage.Actor extends Mirage.Object

  @initialize ->
    @dead = false

  render: ->

  action: (deltaTime) ->

  die: ->
    @dead = true
