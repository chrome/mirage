class Mirage.ImageResource extends Mirage.Resource

  image: null

  width: 0
  height: 0

  constructor: (@id, @url) ->

  load: (cb) ->
    @image = new Image()
    @image.onload = =>
      @width = @image.width
      @height = @image.height
      @loaded = true
      cb?()
    @image.src = @url

  unload: ->
    @loaded = false
    delete @image
    @image = null
    @width = 0
    @height = 0

  get: -> @image
