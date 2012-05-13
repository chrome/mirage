class TestSprite extends Mirage.AnimatedSprite

  initialize: (@flyAnimation, @standAnimation) ->
    @angle = Math.PI / 2
    @inMove = false

  action: (dT) ->
    @inMove = false
    if Mirage.controls().isDown(Mirage.KEYS.right)
      @angle += Math.PI / 2 * dT
      @inMove = true
    else if Mirage.controls().isDown(Mirage.KEYS.left)
      @angle -= Math.PI / 2 * dT
      @inMove = true

    if Mirage.controls().isDown(Mirage.KEYS.up)
      dX = Math.cos(@angle - Math.PI / 2) * 200 * dT
      dY = Math.sin(@angle - Math.PI / 2) * 200 * dT
      @x += dX
      @y += dY
      @inMove = true

    if @inMove
      @setAnimation(@flyAnimation)
      @play()
    else
      @setAnimation(@standAnimation)
      @stop()

class TestGame extends Mirage.Game
  initialize: ->
    Mirage.controls(new Mirage.Controls())
    @rm = new Mirage.ResourceManager()

    @rm.add(new Mirage.ImageResource('ship', '/images/spaceship.png'))

    animation = new Mirage.Animation('ship-fly')
    animation
      .addFrame(42, 40, 42, 46)
      .addFrame(42, 86, 42, 46)
      .setSpeed(10)
    @rm.add(animation)

    animation = new Mirage.Animation('ship-stand')
    animation
      .addFrame(42, 0, 42, 46)
      .setSpeed(1)
    @rm.add(animation)

    @addScene(new Mirage.Scene('main'))
    @setActiveScene('main')

    @rm.loadAll =>
      @createActors()
      @startLoop()

  createActors: ->
    @getScene('main')
      .addActor(new TestSprite('ship', @rm.get('ship'), @rm.get('ship-fly'), @rm.get('ship-stand')))
      .getActor('ship')
        .moveTo(300, 200)
        .setAnimation(@rm.get('ship-stand'))

window.onload = ->
  game = new TestGame()