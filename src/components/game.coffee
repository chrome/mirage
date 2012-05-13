class Mirage.Game extends Mirage.Object

  scenes: {}
  activeScene: null

  lastLoopTime: 0

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
    Mirage.getRenderer().clear()
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
    @lastLoopTime = now if @lastLoopTime == 0
    deltaTime = now - @lastLoopTime
    @lastLoopTime = now

    @action(deltaTime / 1000)
    @render()

    @loop(deltaTime)
    @queueNextLoop()

  loop: (deltaTime) ->