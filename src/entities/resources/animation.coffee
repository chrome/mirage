class Mirage.Animation extends Mirage.Resource


  constructor: ->
    @frames = []
    @loop = true
    @speed = 2 # frames per second
    super

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
