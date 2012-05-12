class Mirage.Game extends Mirage.Object

  scenes: {}
  activeScene: null

  lastLoopTime: 0

  constructor: (@id) ->
    @initialize?()

  addScene: (scene) ->
    @scenes[scene.id] = scene

  removeScene: (id) ->
    delete @scenes[id]

  getScene: (id) ->
    @scenes[id]

  setActiveScene: (id) ->
    @activeScene = @getScene(id)

  render: ->
    @activeScene?.render()

  startLoop: ->
    @queueNextLoop()

  queueNextLoop: ->
    if window.requestAnimationFrame
      window.requestAnimationFrame => @mainLoop()
    else if window.msRequestAnimationFrame
      window.msRequestAnimationFrame => @mainLoop()
    else if window.webkitRequestAnimationFrame
      window.webkitRequestAnimationFrame => @mainLoop()
    else if window.mozRequestAnimationFrame
      window.mozRequestAnimationFrame => @mainLoop()
    else
      alert 'No game for you! :('

  mainLoop: ->
    now = Date.now()
    deltaTime = now - @lastLoopTime
    @lastLoopTime = now

    @activeScene?.action?(deltaTime)
    @activeScene?.render?()

    @loop(deltaTime)
    @queueNextLoop()