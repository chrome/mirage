class Mirage.Controls

  keys: {}
  mouse:
    x: 0
    y: 0
    button: false
    stillDown: false

  constructor: ->
    window.onmousedown = (event) =>
      @mouse.button = true
      @mouse.stillDown = true

    window.onmouseup = (event) =>
      @mouse.stillDown = true

    window.onkeydown = (event) =>
      @set event.keyCode, true

    window.onkeyup = (event) =>
      @set event.keyCode, false

    window.onmousemove = (event) =>
      @mouse.x = event.clientX
      @mouse.y = event.clientY



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