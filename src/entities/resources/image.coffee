class Mirage.ImageResource extends Mirage.Resource


  constructor: ->
    @image = null

    @width = 0
    @height = 0
    super

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
