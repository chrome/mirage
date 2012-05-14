class Mirage.Animation extends Mirage.Resource


  @initialize ->
    @frames = []
    @loop = true
    @speed = 2 # frames per second

  addFrame: (x, y, width, height) ->
    @frames.push
      x: x
      y: y
      width: width
      height: height
    @

  setSpeed: (@speed) ->
    @

  getFrame: (index) ->
    @frames[index]

  framesCount: ->
    @frames.length
