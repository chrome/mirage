class Mirage.Controls

  constructor: (targetElement = window) ->
    @keys = {}
    @mouse =
      x: 0
      y: 0
      button: false
      stillDown: false

    targetElement.onmousedown = (event) =>
      event.preventDefault()
      @mouse.button = true
      @mouse.stillDown = true

    targetElement.onmouseup = (event) =>
      event.preventDefault()
      @mouse.stillDown = true

    targetElement.onmousemove = (event) =>
      @mouse.x = event.clientX
      @mouse.y = event.clientY

    targetElement.onkeydown = (event) =>
      event.preventDefault()
      @set event.keyCode, true

    targetElement.onkeyup = (event) =>
      event.preventDefault()
      @set event.keyCode, false




  set: (keyCode, pressed) ->
    if pressed
      @keys[keyCode] = down: pressed, stillDown: true
    else
      @keys[keyCode]?.stillDown = false

  isDown: (keyCode) ->
    @keys[keyCode]? && @keys[keyCode].down

  clear: ->
    for code, key of @keys
      unless key.stillDown
        key.down = false
    unless @mouse.stillDown
      @mouse.button = false

Mirage.KEYS =
  'up':    38
  'down':  40
  'left':  37
  'right': 39