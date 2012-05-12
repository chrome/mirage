class Mirage.Renderer
  constructor: (@hostElement) ->
    @hostElement = $(@hostElement)
    @initialize()

  initialize: ->
    @canvas = $('<canvas />')
    @canvas
      .attr(
        width: @hostElement.width()
        height: @hostElement.height()
      )
    @hostElement.empty().append(@canvas)
    console.log @hostElement
    @context = @canvas.get(0).getContext('2d')

  getCanvas: ->
    @canvas

  getContext: ->
    @context

  drawImage: (x, y, angle, scale, image, imageX, imageY, imageW, imageH) ->
    image = image.get() if image.get?
    @context.translate(x, y)
    @context.rotate(-angle)
    @context.scale(scale, scale)

    dx = image.width / 2
    dy = image.height / 2

    if imageX? and imageY? and imageW? and imageH?
      @context.drawImage(image, imageX, imageY, imageW, imageH, -imageW / 2, -imageH / 2, imageW, imageH)
    else
      @context.drawImage(image, -image.width / 2, -image.height / 2)

    @context.scale(1 / scale, 1 / scale)
    @context.rotate(angle)
    @context.translate(-x, -y)

  clear: ->
