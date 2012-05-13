class Mirage.Renderer
  constructor: (@hostElementId) ->
    @hostElement = document.getElementById(@hostElementId)
    @hostElement ||= document.getElementsByTagName('body')[0]
    @initialize()

  initialize: ->
    @canvas = document.createElement('canvas')
    @canvas.setAttribute('width', @hostElement.offsetWidth)
    @canvas.setAttribute('height', @hostElement.offsetHeight)

    @hostElement.innerHTML = ''
    @hostElement.appendChild(@canvas)
    @context = @canvas.getContext('2d')

  getCanvas: ->
    @canvas

  getContext: ->
    @context

  drawImage: (x, y, angle, scale, image, imageX, imageY, imageW, imageH) ->
    image = image.get() if image.get?
    @context.translate(x, y)
    @context.rotate(-angle)
    @context.scale(scale, scale)

    if imageX? and imageY? and imageW? and imageH?
      @context.drawImage(image, imageX, imageY, imageW, imageH, -imageW / 2, -imageH / 2, imageW, imageH)
    else
      @context.drawImage(image, -image.width / 2, -image.height / 2)

    @context.scale(1 / scale, 1 / scale)
    @context.rotate(angle)
    @context.translate(-x, -y)

  clear: ->
