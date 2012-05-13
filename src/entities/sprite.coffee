class Mirage.Sprite extends Mirage.Actor

  constructor: (@id, @image, options...) ->
    @x = 0
    @y = 0
    @angle = 0
    @scale = 1
    @initialize?(options...)

  moveTo: (dX, dY) ->
    [@x, @y] = [dX, dY]
    @

  render: ->
    Mirage.renderer()
      .drawImage(
        @image
        x: @x
        y: @y
        angle: @angle
        scale: @scale
      )