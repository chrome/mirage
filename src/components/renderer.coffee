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

  drawImage: (image, options = {}) ->
    x = options.x || 0
    y = options.y || 0
    scale = options.scale || 1
    angle = options.angle || 0
    imageX = options.cropStartX || 0
    imageY = options.cropStartY || 0
    imageW = options.cropWidth || image.width - imageX
    imageH = options.cropHeight || image.height - imageY

    image = image.get() if image.get?
    @context.translate(x, y)
    @context.rotate(angle)
    @context.scale(scale, scale)

    if imageX? and imageY? and imageW? and imageH?
      @context.drawImage(image, imageX, imageY, imageW, imageH, -imageW / 2, -imageH / 2, imageW, imageH)
    else
      @context.drawImage(image, -image.width / 2, -image.height / 2)

    @context.scale(1 / scale, 1 / scale)
    @context.rotate(-angle)
    @context.translate(-x, -y)
    @

  clear: (backgroundImage)->
    if backgroundImage?
      ptrn = @context.createPattern(backgroundImage.get(),'repeat')
      @context.fillStyle = ptrn
      @context.fillRect(-@canvas.width,-@canvas.height,@canvas.width*3,@canvas.height*3)
    else
      @canvas.setAttribute('width', @canvas.getAttribute('width'))
