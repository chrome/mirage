class Mirage.Sprite extends Mirage.Actor

  @initialize (options) ->
    @extractOptions(options, 'image')
    @x = 0
    @y = 0
    @angle = 0
    @scale = 1

  moveTo: (dX, dY) ->
    [@x, @y] = [dX, dY]
    @

  translate: (dX, dY) ->
    @x += dX
    @y += dY
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