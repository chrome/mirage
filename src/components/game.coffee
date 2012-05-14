class Mirage.Game

  @initialize: (initializer) ->
    @prototype.initialize = initializer

  constructor: ->
    @scenes = {}
    @activeScene = null

    @lastLoopTime = 0
    @initialize?()

  addScene: (scene) ->
    @scenes[scene.id] = scene

  removeScene: (id) ->
    delete @scenes[id]

  getScene: (id) ->
    @scenes[id]

  setActiveScene: (id) ->
    @activeScene = @getScene(id)

  action: (deltaTime) ->
    @activeScene?.action?(deltaTime)

  render: ->
    Mirage.renderer().getContext().translate(-@activeScene.x, -@activeScene.y)
    Mirage.renderer().clear(@activeScene.backgroundImage)
    @activeScene?.render()
    Mirage.renderer().getContext().translate(@activeScene.x, @activeScene.y)

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
    @lastLoopTime = now if @lastLoopTime == 0
    deltaTime = now - @lastLoopTime
    @lastLoopTime = now

    @action(deltaTime / 1000)
    Mirage.controls()?.clear()
    @render()

    @loop(deltaTime)
    @queueNextLoop()

  loop: (deltaTime) ->